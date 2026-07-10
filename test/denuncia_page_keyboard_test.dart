import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:protege_saude/features/denuncia/controllers/denuncia_controller.dart';
import 'package:protege_saude/features/denuncia/denuncia_page.dart';
import 'package:protege_saude/shared/config/api_config.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/models/profession.dart';
import 'package:protege_saude/shared/models/public_form.dart';
import 'package:protege_saude/shared/network/api_client.dart';
import 'package:protege_saude/shared/network/public_api.dart';
import 'package:protege_saude/shared/persistence/draft_repository.dart';
import 'package:protege_saude/shared/services/pdf_service.dart';
import 'package:protege_saude/shared/services/photo_service.dart';

void main() {
  testWidgets('barra inferior do formulario respeita teclado aberto', (
    tester,
  ) async {
    final controller = _testController()
      ..selectedProfession = Profession.fromJson({
        'id': 1,
        'nome': 'Odontologia',
        'cor': '24786B',
        'status': 1,
      })
      ..loadedForm = PublicForm.fromJson({
        'profissao': {'id': 1, 'nome': 'Odontologia'},
        'passos': <Map<String, Object?>>[],
      })
      ..address = const ComplaintAddress()
      ..wizardStarted = true;

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(viewInsets: const EdgeInsets.only(bottom: 300)),
            child: child!,
          );
        },
        home: ChangeNotifierProvider.value(
          value: controller,
          child: const DenunciaPage(),
        ),
      ),
    );

    final padding = tester.widget<AnimatedPadding>(
      find.byKey(const ValueKey('denunciaKeyboardAwareBottomBarPadding')),
    );

    expect(padding.padding, const EdgeInsets.only(bottom: 300));
  });
}

DenunciaController _testController() {
  return DenunciaController(
    api: _FakePublicApi(),
    draftRepository: _FakeDraftRepository(),
    pdfService: PdfService(),
    photoService: PhotoService(),
  );
}

class _FakePublicApi extends PublicApi {
  _FakePublicApi()
    : super(
        ApiClient(config: const ApiConfig(baseUrl: 'https://test.dev/api')),
      );

  @override
  Future<List<Profession>> fetchPublicProfessions() async {
    return [
      Profession.fromJson({
        'id': 1,
        'nome': 'Odontologia',
        'cor': '24786B',
        'status': 1,
      }),
    ];
  }
}

class _FakeDraftRepository extends DraftRepository {
  @override
  Future<ComplaintDraft?> loadDraft(int professionId) async => null;

  @override
  Future<void> saveDraft(ComplaintDraft draft) async {}

  @override
  Future<void> deleteDraft(int professionId) async {}

  @override
  Future<void> saveConfirmation(ConfirmationRecord record) async {}

  @override
  Future<ConfirmationRecord?> loadConfirmation() async => null;
}
