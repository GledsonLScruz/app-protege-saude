import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:protege_saude/features/confirmacao/confirmacao_denuncia_page.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/persistence/draft_repository.dart';
import 'package:protege_saude/shared/services/external_actions.dart';

void main() {
  testWidgets('exibe avaliacao apos confirmar denuncia e abre formulario', (
    tester,
  ) async {
    final actions = _RecordingExternalActions();

    await tester.pumpWidget(
      _host(
        repository: _ConfirmationRepository(_confirmation()),
        actions: actions,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Avalie nossa plataforma'), findsOneWidget);
    expect(find.text('Avaliar agora'), findsOneWidget);
    expect(find.text('Mais tarde'), findsOneWidget);

    await tester.tap(find.text('Avaliar agora'));
    await tester.pumpAndSettle();

    expect(actions.openedUrl, 'https://forms.gle/w5mmUvYX5vVS4Ufw7');
  });
}

Widget _host({
  required DraftRepository repository,
  required ExternalActions actions,
}) {
  return MultiProvider(
    providers: [
      Provider<DraftRepository>.value(value: repository),
      Provider<ExternalActions>.value(value: actions),
    ],
    child: const MaterialApp(home: ConfirmacaoDenunciaPage()),
  );
}

ConfirmationRecord _confirmation() {
  return ConfirmationRecord(
    protocol: 'DEN-2026-123456',
    pdfPath: '/tmp/denuncia.pdf',
    sentAt: DateTime(2026, 7, 7, 10, 30),
    professionId: 1,
    professionName: 'Medicina',
    councilName: 'Conselho Tutelar Centro',
  );
}

class _ConfirmationRepository extends DraftRepository {
  _ConfirmationRepository(this.confirmation);

  final ConfirmationRecord? confirmation;

  @override
  Future<ConfirmationRecord?> loadConfirmation() async => confirmation;
}

class _RecordingExternalActions extends ExternalActions {
  String? openedUrl;

  @override
  Future<void> openUrl(String url) async {
    openedUrl = url;
  }
}
