import 'package:flutter/foundation.dart';

import '../../../shared/models/guide_document.dart';
import '../../../shared/models/profession.dart';
import '../../../shared/network/api_exception.dart';
import '../../../shared/network/public_api.dart';
import '../../../shared/services/document_file_service.dart';

class DocumentosController extends ChangeNotifier {
  DocumentosController({
    required PublicApi api,
    required DocumentFileService fileService,
    int? initialProfessionId,
  }) : _api = api,
       _fileService = fileService,
       _initialProfessionId = initialProfessionId;

  final PublicApi _api;
  final DocumentFileService _fileService;
  final int? _initialProfessionId;

  List<Profession> professions = const [];
  List<GuideDocument> documents = const [];
  Profession? selectedProfession;
  bool isLoadingProfessions = false;
  bool isLoadingDocuments = false;
  String? professionsError;
  String? documentsError;
  final Map<int, String> downloadedPaths = {};
  Set<int> downloading = {};

  Future<void> load() async {
    isLoadingProfessions = true;
    professionsError = null;
    notifyListeners();
    try {
      professions = await _api.fetchDocumentProfessions();
      if (_initialProfessionId != null) {
        for (final profession in professions) {
          if (profession.id == _initialProfessionId) {
            await selectProfession(profession);
            break;
          }
        }
      }
    } on Object catch (error) {
      professionsError = _messageFor(error);
    } finally {
      isLoadingProfessions = false;
      notifyListeners();
    }
  }

  Future<void> selectProfession(Profession profession) async {
    selectedProfession = profession;
    documents = const [];
    documentsError = null;
    isLoadingDocuments = true;
    notifyListeners();
    try {
      documents = await _api.fetchDocuments(profession.id);
    } on Object catch (error) {
      documentsError = _messageFor(error);
    } finally {
      isLoadingDocuments = false;
      notifyListeners();
    }
  }

  Future<String?> download(GuideDocument document) async {
    if (!canDownload(document)) {
      return 'Documento sem arquivo disponível para download.';
    }
    downloading = {...downloading, document.id};
    notifyListeners();
    try {
      final path = await _fileService.downloadDocument(document);
      downloadedPaths[document.id] = path;
      return null;
    } on Object catch (error) {
      return _messageFor(error);
    } finally {
      downloading = {...downloading}..remove(document.id);
      notifyListeners();
    }
  }

  String normalizeUrl(String? url) => _api.normalizeFileUrl(url);

  bool canDownload(GuideDocument document) =>
      _fileService.canDownload(document);

  String? coverAssetFor(GuideDocument document) =>
      _fileService.coverAssetFor(document);

  String _messageFor(Object error) {
    if (error is ApiException) {
      return error.message;
    }
    if (error is DocumentUnavailableException) {
      return error.message;
    }
    return 'Não foi possível carregar os dados. Verifique sua internet e tente novamente.';
  }
}
