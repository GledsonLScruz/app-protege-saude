import 'package:open_filex/open_filex.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalActions {
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw StateError('Nao foi possivel abrir o link.');
    }
  }

  Future<void> callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      throw StateError('Nao foi possivel iniciar a chamada.');
    }
  }

  Future<void> shareText(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }

  Future<void> shareFile(String path, {String? text}) async {
    await Share.shareXFiles([XFile(path)], text: text);
  }

  Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }

  Future<void> printPdf(String path) async {
    await Printing.layoutPdf(onLayout: (_) async => XFile(path).readAsBytes());
  }
}
