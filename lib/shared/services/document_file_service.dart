import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_assets.dart';
import '../models/guide_document.dart';
import '../network/api_client.dart';
import '../network/public_api.dart';
import '../utils/text_normalizer.dart';

class DocumentFileService {
  DocumentFileService({required ApiClient client, required PublicApi publicApi})
    : _client = client,
      _publicApi = publicApi;

  final ApiClient _client;
  final PublicApi _publicApi;

  bool canDownload(GuideDocument document) {
    return _publicApi.normalizeFileUrl(document.arquivo).isNotEmpty ||
        document.localFallback != null;
  }

  Future<String> downloadDocument(GuideDocument document) async {
    final directory = await getApplicationDocumentsDirectory();
    final docsDirectory = Directory(p.join(directory.path, 'documentos'));
    if (!await docsDirectory.exists()) {
      await docsDirectory.create(recursive: true);
    }
    final fileName = _safeFileName('${document.titulo}.pdf');
    final destination = p.join(docsDirectory.path, fileName);
    final remote = _publicApi.normalizeFileUrl(document.arquivo);
    if (remote.isNotEmpty) {
      await _client.download(remote, destination);
      return destination;
    }
    final fallback = document.localFallback;
    if (fallback == null) {
      throw const DocumentUnavailableException(
        'Documento sem arquivo disponível para download.',
      );
    }
    final bytes = await rootBundle.load(assetForDocument(fallback));
    await File(destination).writeAsBytes(bytes.buffer.asUint8List());
    return destination;
  }

  Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }

  String? coverAssetFor(GuideDocument document) {
    final fallback = document.localFallback;
    return fallback == null ? null : coverForDocument(fallback);
  }

  String? fallbackAssetFor(GuideDocument document) {
    final fallback = document.localFallback;
    return fallback == null ? null : assetForDocument(fallback);
  }

  String coverForDocument(KnownLocalDocument document) {
    return switch (document) {
      KnownLocalDocument.eca => AppAssets.ecaCover,
      KnownLocalDocument.ethics => AppAssets.ethicsCover,
      KnownLocalDocument.constitution => AppAssets.constitutionCover,
    };
  }

  String assetForDocument(KnownLocalDocument document) {
    return switch (document) {
      KnownLocalDocument.eca => AppAssets.ecaPdf,
      KnownLocalDocument.ethics => AppAssets.ethicsPdf,
      KnownLocalDocument.constitution => AppAssets.constitutionPdf,
    };
  }

  String _safeFileName(String value) {
    final normalized = normalizeLooseText(
      value,
    ).replaceAll(RegExp(r'[^a-z0-9.]+'), '_').replaceAll(RegExp(r'_+'), '_');
    return normalized.endsWith('.pdf') ? normalized : '$normalized.pdf';
  }
}

class DocumentUnavailableException implements Exception {
  const DocumentUnavailableException(this.message);

  final String message;

  @override
  String toString() => message;
}
