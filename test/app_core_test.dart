import 'dart:math';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/shared/config/api_config.dart';
import 'package:protege_saude/shared/models/cep_validation.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/models/guide_document.dart';
import 'package:protege_saude/shared/models/profession.dart';
import 'package:protege_saude/shared/models/public_form.dart';
import 'package:protege_saude/shared/network/api_client.dart';
import 'package:protege_saude/shared/network/public_api.dart';
import 'package:protege_saude/shared/services/document_file_service.dart';
import 'package:protege_saude/shared/services/dynamic_field_validator.dart';
import 'package:protege_saude/shared/services/protocol_generator.dart';

void main() {
  test('normaliza API_BASE_URL para terminar em /api', () {
    expect(
      ApiConfig.normalizeBaseUrl('https://example.com/'),
      'https://example.com/api',
    );
    expect(
      ApiConfig.normalizeBaseUrl('https://example.com/api/'),
      'https://example.com/api',
    );
  });

  test('parseia profissao publica com campos opcionais', () {
    final profession = Profession.fromJson({
      'id': '1',
      'nome': 'Odontologia',
      'descricao': null,
      'cor': '24786B',
      'status': 1,
    });

    expect(profession.id, 1);
    expect(profession.displayDescription, contains('Formulario configurado'));
  });

  test('parseia formulario publico e ordena passos/campos', () {
    final form = PublicForm.fromJson({
      'profissao': {'id': 1, 'nome': 'Odontologia'},
      'passos': [
        {'id': 2, 'ordem_index': 2, 'titulo': 'Segundo', 'campos': []},
        {
          'id': 1,
          'ordem_index': 1,
          'titulo': 'Primeiro',
          'campos': [
            {'id': 11, 'ordem_index': 2, 'nome': 'B', 'tipo_campo': 'texto'},
            {'id': 10, 'ordem_index': 1, 'nome': 'A', 'tipo_campo': 'texto'},
          ],
        },
      ],
    });

    expect(form.orderedSteps.map((step) => step.id), [1, 2]);
    expect(form.orderedSteps.first.campos.map((field) => field.id), [10, 11]);
  });

  test('parseia CEP permitido e bloqueado', () {
    final allowed = CepValidationResult.fromJson({
      'podeProsseguir': true,
      'endereco': {
        'cep': '58406000',
        'estado': 'PB',
        'cidade': 'Campina Grande',
        'bairro': 'Santo Antonio',
        'logradouro': 'Rua Exemplo',
      },
      'conselho': {'id': 2, 'nome': 'Conselho Tutelar Sul'},
    });
    expect(allowed, isA<CepAllowed>());

    final blocked = CepValidationResult.fromJson({
      'podeProsseguir': false,
      'codigo': 'CEP_INVALIDO',
      'mensagem': 'CEP invalido.',
    });
    expect(blocked, isA<CepBlocked>());
  });

  test('valida campos dinamicos principais', () {
    const validator = DynamicFieldValidator();
    final requiredText = PublicFormField.fromJson({
      'id': 1,
      'nome': 'Relato',
      'tipo_campo': 'texto',
      'obrigatorio': true,
    });
    expect(validator.validateField(requiredText, ''), isNotNull);
    expect(validator.validateField(requiredText, 'ok'), isNull);

    final number = PublicFormField.fromJson({
      'id': 2,
      'nome': 'Idade',
      'tipo_campo': 'numero',
    });
    expect(validator.validateField(number, 'abc'), 'Informe um numero valido.');

    final checkbox = PublicFormField.fromJson({
      'id': 3,
      'nome': 'Sinais',
      'tipo_campo': 'checkbox',
      'obrigatorio': true,
      'opcoes': [
        {'valor': 'medo', 'label': 'Medo'},
      ],
    });
    expect(validator.validateField(checkbox, <String>[]), isNotNull);
    expect(validator.validateField(checkbox, ['medo']), isNull);
  });

  test('switch condicional valida somente opcoes permitidas/renderizaveis', () {
    const validator = DynamicFieldValidator();
    final field = PublicFormField.fromJson({
      'id': 4,
      'nome': 'Houve relato?',
      'tipo_campo': 'switch',
      'opcoes': [
        {'valor': 'permitida', 'label': 'Permitida'},
        {'valor': 'bloqueada', 'label': 'Bloqueada'},
      ],
      'validacoes': {
        'opcoes_condicionais_permitidas': ['permitida'],
      },
    });

    expect(field.conditionalOptions.map((option) => option.valor), [
      'permitida',
    ]);
    expect(
      validator.validateField(field, {
        'valor': true,
        'selecionados': ['permitida'],
      }),
      isNull,
    );
    expect(
      validator.validateField(field, {
        'valor': true,
        'selecionados': ['bloqueada'],
      }),
      'Opcao invalida.',
    );
  });

  test(
    'DocumentFileService libera download apenas com arquivo ou fallback local',
    () {
      final client = ApiClient(
        config: const ApiConfig(baseUrl: 'https://backend.test/api'),
      );
      final api = PublicApi(client);
      final service = DocumentFileService(client: client, publicApi: api);

      expect(
        service.canDownload(
          GuideDocument.fromJson({
            'id': 1,
            'titulo': 'Manual remoto',
            'arquivo': '/uploads/manual.pdf',
          }),
        ),
        isTrue,
      );
      expect(
        service.canDownload(
          GuideDocument.fromJson({
            'id': 2,
            'titulo': 'ECA - Estatuto da Crianca e do Adolescente',
          }),
        ),
        isTrue,
      );
      expect(
        service.canDownload(
          GuideDocument.fromJson({'id': 3, 'titulo': 'Manual sem arquivo'}),
        ),
        isFalse,
      );
    },
  );

  test('normaliza pontos de foco de documentos', () {
    final points = focusPointsFromJson('[{"titulo":"Art. 245","pagina":121}]');
    expect(points.single.titulo, 'Art. 245');
    expect(points.single.pagina, 121);
  });

  test('gera protocolo no formato esperado', () {
    final protocol = ProtocolGenerator(
      random: Random(1),
    ).generate(now: DateTime(2026));
    expect(protocol, matches(RegExp(r'^DEN-2026-\d{6}$')));
  });

  test('envio de denuncia monta multipart com PDF e metadados', () async {
    final client = _CapturingApiClient();
    final api = PublicApi(client);
    final pdfFile = File(
      '${Directory.systemTemp.createTempSync('protege_pdf_').path}/denuncia.pdf',
    );
    await pdfFile.writeAsBytes([1, 2, 3]);
    addTearDown(() async {
      if (await pdfFile.parent.exists()) {
        await pdfFile.parent.delete(recursive: true);
      }
    });

    final protocol = await api.submitComplaint(
      protocol: 'DEN-2026-123456',
      professionId: 7,
      address: const ComplaintAddress(
        cep: '58406-000',
        estado: 'PB',
        cidade: 'Campina Grande',
        bairro: 'Santo Antonio',
        conselhoId: 2,
        conselhoRegiao: 'Sul',
      ),
      pdfPath: pdfFile.path,
    );

    expect(protocol, 'DEN-2026-654321');
    expect(client.lastPath, 'denuncia');
    expect(client.lastOptions?.contentType, 'multipart/form-data');
    final formData = client.lastData as FormData;
    expect(_field(formData, 'protocolo'), 'DEN-2026-123456');
    expect(_field(formData, 'profissao_id'), '7');
    expect(_field(formData, 'regiao'), 'Sul');
    expect(_field(formData, 'cep'), '58406000');
    expect(formData.files.single.key, 'pdf');
    expect(
      formData.files.single.value.filename,
      'denuncia_DEN-2026-123456.pdf',
    );
  });
}

class _CapturingApiClient extends ApiClient {
  _CapturingApiClient()
    : super(config: const ApiConfig(baseUrl: 'https://backend.test/api'));

  String? lastPath;
  Object? lastData;
  Options? lastOptions;

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Options? options,
  }) async {
    lastPath = path;
    lastData = data;
    lastOptions = options;
    return Response<T>(
      data: {'protocolo': 'DEN-2026-654321'} as T,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }
}

String? _field(FormData formData, String name) {
  for (final entry in formData.fields) {
    if (entry.key == name) {
      return entry.value;
    }
  }
  return null;
}
