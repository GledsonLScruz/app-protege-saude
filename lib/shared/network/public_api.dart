import 'package:dio/dio.dart';

import '../models/cep_validation.dart';
import '../models/complaint_models.dart';
import '../models/guide_document.dart';
import '../models/profession.dart';
import '../models/public_form.dart';
import '../utils/text_normalizer.dart';
import 'api_client.dart';
import 'api_exception.dart';

class PublicApi {
  PublicApi(this._client);

  static const _complaintUploadSendTimeout = Duration(minutes: 2);
  static const _complaintUploadReceiveTimeout = Duration(minutes: 1);

  final ApiClient _client;

  Future<List<Profession>> fetchPublicProfessions() async {
    final response = await _client.get<dynamic>('public/profissoes');
    return _parseProfessionList(response.data);
  }

  Future<PublicForm> fetchPublicForm(int professionId) async {
    final response = await _client.get<dynamic>(
      'public/profissoes/$professionId/formulario',
    );
    final data = _asMap(response.data);
    return PublicForm.fromJson(data);
  }

  Future<CepValidationResult> validateCep(String cep) async {
    final normalized = onlyDigits(cep);
    try {
      final response = await _client.get<dynamic>(
        'denuncia/validar-cep/$normalized',
        options: Options(validateStatus: (status) => (status ?? 500) < 500),
      );
      return CepValidationResult.fromJson(_asMap(response.data));
    } on ApiException catch (error) {
      final cause = error.cause;
      if (cause is DioException && cause.response?.data != null) {
        return CepValidationResult.fromJson(_asMap(cause.response!.data));
      }
      rethrow;
    }
  }

  Future<String> submitComplaint({
    required String protocol,
    required int professionId,
    required ComplaintAddress address,
    required String pdfPath,
  }) async {
    final formData = FormData.fromMap({
      'protocolo': protocol,
      'profissao_id': professionId.toString(),
      'regiao': address.conselhoRegiao ?? address.bairro,
      'cep': onlyDigits(address.cep),
      'estado': address.estado,
      'cidade': address.cidade,
      'bairro': address.bairro,
      if (address.conselhoId != null) 'conselho_id': address.conselhoId,
      'pdf': await MultipartFile.fromFile(
        pdfPath,
        filename: 'denuncia_$protocol.pdf',
        contentType: DioMediaType('application', 'pdf'),
      ),
    });
    final response = await _client.post<dynamic>(
      'denuncia',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        sendTimeout: _complaintUploadSendTimeout,
        receiveTimeout: _complaintUploadReceiveTimeout,
      ),
    );
    final data = _asMap(response.data);
    return (data['protocolo'] ?? protocol).toString();
  }

  Future<List<Profession>> fetchDocumentProfessions() async {
    final response = await _client.get<dynamic>('profissoes');
    return _parseProfessionList(response.data);
  }

  Future<List<GuideDocument>> fetchDocuments(int professionId) async {
    final response = await _client.get<dynamic>(
      'profissoes/$professionId/documentos',
    );
    final list = _unwrapList(response.data);
    return list
        .whereType<Object?>()
        .map((item) => GuideDocument.fromJson(_asMap(item)))
        .toList();
  }

  String normalizeFileUrl(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) {
      return '';
    }
    final uri = Uri.tryParse(raw);
    if (uri != null && uri.hasScheme) {
      return raw;
    }
    String origin = _client.config.origin;
    if (origin.contains('?#')) {
      origin = origin.replaceAll('?#', '');
    }
    final path = raw.startsWith('/') ? raw : '/$raw';
    return '$origin$path';
  }

  List<Profession> _parseProfessionList(Object? data) {
    return _unwrapList(data)
        .whereType<Object?>()
        .map((item) => Profession.fromJson(_asMap(item)))
        .toList();
  }
}

List<dynamic> _unwrapList(Object? data) {
  if (data is List) {
    return data;
  }
  if (data is Map) {
    for (final key in const ['profissoes', 'professions', 'items', 'data']) {
      final value = data[key];
      if (value is List) {
        return value;
      }
    }
  }
  return const [];
}

Map<String, dynamic> _asMap(Object? data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return data.map((key, value) => MapEntry(key.toString(), value));
  }
  return <String, dynamic>{};
}
