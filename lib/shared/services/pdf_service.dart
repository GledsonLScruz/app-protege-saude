import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../models/complaint_models.dart';
import '../models/profession.dart';
import '../models/public_form.dart';
import '../utils/date_utils.dart';
import 'complaint_pdf_html_renderer.dart';
import 'complaint_summary_builder.dart';

class PdfService {
  static const _summaryBuilder = ComplaintSummaryBuilder();
  static const _pageTopMargin = 36.0;
  static const _pageBottomMargin = 30.0;

  Future<String> generateComplaintPdf({
    required String protocol,
    required Profession profession,
    required ComplaintAddress address,
    required PublicForm form,
    required Map<String, Map<String, dynamic>> answers,
    required Map<String, List<PhotoRef>> photos,
  }) async {
    final generatedAt = DateTime.now();
    final sections = _summaryBuilder.build(
      address: address,
      form: form,
      answers: answers,
      photos: photos,
    );
    final template = await loadComplaintPdfTemplate();
    final html = await buildComplaintPdfHtml(
      templateHtml: template.html,
      templateCss: template.css,
      generatedAt: formatDateBr(simpleIsoDate(generatedAt)),
      professionName: profession.nome,
      sections: sections,
    );
    final pdfBytes = await _convertHtmlToPdf(html);

    final directory = await getApplicationDocumentsDirectory();
    final pdfDirectory = Directory(p.join(directory.path, 'denuncias'));
    if (!await pdfDirectory.exists()) {
      await pdfDirectory.create(recursive: true);
    }
    final file = File(p.join(pdfDirectory.path, 'denuncia_$protocol.pdf'));
    await file.writeAsBytes(pdfBytes);
    return file.path;
  }

  Future<List<int>> _convertHtmlToPdf(String html) async {
    // ignore: deprecated_member_use
    return Printing.convertHtml(
      html: html,
      format: PdfPageFormat.a4.copyWith(
        marginBottom: _pageBottomMargin,
        marginLeft: 0,
        marginRight: 0,
        marginTop: _pageTopMargin,
      ),
    );
  }
}
