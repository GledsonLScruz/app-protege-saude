import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/features/denuncia/controllers/denuncia_controller.dart';
import 'package:protege_saude/shared/config/api_config.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/models/public_form.dart';
import 'package:protege_saude/shared/network/api_client.dart';
import 'package:protege_saude/shared/network/public_api.dart';
import 'package:protege_saude/shared/persistence/draft_repository.dart';
import 'package:protege_saude/shared/services/pdf_service.dart';
import 'package:protege_saude/shared/services/photo_service.dart';

void main() {
  test(
    'controller retorna mensagem clara quando galeria nega permissao',
    () async {
      final controller = _controller(
        photoService: _FailingPhotoService(
          galleryMessage: 'Permissao para acessar a galeria foi negada.',
        ),
      );
      final field = _photoField();

      final message = await controller.addPhotosFromGallery(field);

      expect(message, 'Permissao para acessar a galeria foi negada.');
    },
  );

  test(
    'controller retorna mensagem clara quando camera nega permissao',
    () async {
      final controller = _controller(
        photoService: _FailingPhotoService(
          cameraMessage: 'Permissao para acessar a camera foi negada.',
        ),
      );
      final field = _photoField();

      final message = await controller.capturePhoto(field);

      expect(message, 'Permissao para acessar a camera foi negada.');
    },
  );
}

DenunciaController _controller({required PhotoService photoService}) {
  return DenunciaController(
    api: PublicApi(
      ApiClient(config: const ApiConfig(baseUrl: 'https://backend.test/api')),
    ),
    draftRepository: DraftRepository(),
    pdfService: PdfService(),
    photoService: photoService,
  );
}

PublicFormField _photoField() => PublicFormField.fromJson({
  'id': 1,
  'nome': 'Fotos',
  'tipo_campo': 'foto',
  'max_fotos': 2,
});

class _FailingPhotoService extends PhotoService {
  _FailingPhotoService({this.galleryMessage, this.cameraMessage});

  final String? galleryMessage;
  final String? cameraMessage;

  @override
  Future<List<PhotoRef>> pickFromGallery({required int remainingSlots}) async {
    throw PhotoSelectionException(galleryMessage ?? 'Erro na galeria.');
  }

  @override
  Future<PhotoRef?> captureFromCamera() async {
    throw PhotoSelectionException(cameraMessage ?? 'Erro na camera.');
  }
}
