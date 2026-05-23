import 'package:flutter/widgets.dart';
import 'package:open_filex/open_filex.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalActions {
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw StateError('Não foi possível abrir o link.');
    }
  }

  Future<void> callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      throw StateError('Não foi possível iniciar a chamada.');
    }
  }

  Future<void> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  Future<void> shareFile(
    String path, {
    String? text,
    Rect? sharePositionOrigin,
  }) async {
    await Share.shareXFiles(
      [XFile(path)],
      text: text,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }

  Future<void> printPdf(String path) async {
    await Printing.layoutPdf(onLayout: (_) async => XFile(path).readAsBytes());
  }

  static Rect? sharePositionOrigin(BuildContext context) {
    Rect? rectFrom(RenderObject? renderObject) {
      if (renderObject is! RenderBox || !renderObject.hasSize) {
        return null;
      }
      final size = renderObject.size;
      if (size.width <= 0 || size.height <= 0) {
        return null;
      }
      final rect = renderObject.localToGlobal(Offset.zero) & size;
      return rect.isFinite && !rect.isEmpty ? rect : null;
    }

    return rectFrom(context.findRenderObject()) ??
        rectFrom(Overlay.maybeOf(context)?.context.findRenderObject());
  }
}
