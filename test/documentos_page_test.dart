import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:protege_saude/features/documentos_norteadores/controllers/documentos_controller.dart';
import 'package:protege_saude/features/documentos_norteadores/documentos_page.dart';
import 'package:protege_saude/shared/config/api_config.dart';
import 'package:protege_saude/shared/models/guide_document.dart';
import 'package:protege_saude/shared/models/profession.dart';
import 'package:protege_saude/shared/network/api_client.dart';
import 'package:protege_saude/shared/network/public_api.dart';
import 'package:protege_saude/shared/services/document_file_service.dart';
import 'package:protege_saude/shared/services/external_actions.dart';

void main() {
  testWidgets('documento sem arquivo nem fallback local nao exibe download', (
    tester,
  ) async {
    final profession = _profession();
    final controller = _controller()
      ..professions = [profession]
      ..selectedProfession = profession
      ..documents = [
        GuideDocument.fromJson({
          'id': 1,
          'titulo': 'Manual sem arquivo',
          'url_online': 'https://example.com/manual',
        }),
      ];

    await tester.pumpWidget(_host(controller: controller));

    expect(find.text('Visualizar Online'), findsOneWidget);
    expect(find.text('Download'), findsNothing);
  });

  testWidgets('erro de download oferece abrir online quando ha URL', (
    tester,
  ) async {
    final actions = _RecordingExternalActions();
    final profession = _profession();
    final document = GuideDocument.fromJson({
      'id': 2,
      'titulo': 'Manual remoto',
      'arquivo': '/uploads/manual.pdf',
      'url_online': 'https://example.com/manual',
    });
    final controller = _FailingDownloadController()
      ..professions = [profession]
      ..selectedProfession = profession
      ..documents = [document];

    await tester.pumpWidget(_host(controller: controller, actions: actions));

    await tester.tap(find.text('Download'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 750));

    expect(find.text('Erro ao baixar'), findsOneWidget);
    expect(find.text('Abrir online'), findsOneWidget);

    await tester.tap(find.text('Abrir online'));
    expect(actions.openedUrl, 'https://example.com/manual');
  });
}

Widget _host({
  required DocumentosController controller,
  ExternalActions? actions,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DocumentosController>.value(value: controller),
      Provider<ExternalActions>.value(value: actions ?? ExternalActions()),
    ],
    child: const MaterialApp(home: DocumentosPage(autoLoad: false)),
  );
}

DocumentosController _controller() {
  final client = ApiClient(
    config: const ApiConfig(baseUrl: 'https://backend.test/api'),
  );
  final api = PublicApi(client);
  return DocumentosController(
    api: api,
    fileService: DocumentFileService(client: client, publicApi: api),
  );
}

Profession _profession() =>
    Profession.fromJson({'id': 1, 'nome': 'Odontologia', 'cor': '#24786B'});

class _FailingDownloadController extends DocumentosController {
  _FailingDownloadController()
    : super(
        api: PublicApi(
          ApiClient(
            config: const ApiConfig(baseUrl: 'https://backend.test/api'),
          ),
        ),
        fileService: DocumentFileService(
          client: ApiClient(
            config: const ApiConfig(baseUrl: 'https://backend.test/api'),
          ),
          publicApi: PublicApi(
            ApiClient(
              config: const ApiConfig(baseUrl: 'https://backend.test/api'),
            ),
          ),
        ),
      );

  @override
  Future<String?> download(GuideDocument document) async => 'Erro ao baixar';
}

class _RecordingExternalActions extends ExternalActions {
  String? openedUrl;

  @override
  Future<void> openUrl(String url) async {
    openedUrl = url;
  }
}
