import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/complaint_models.dart';
import '../models/profession.dart';
import '../models/public_form.dart';
import '../utils/date_utils.dart';

class PdfService {
  Future<String> generateComplaintPdf({
    required String protocol,
    required Profession profession,
    required ComplaintAddress address,
    required PublicForm form,
    required Map<String, Map<String, dynamic>> answers,
    required Map<String, List<PhotoRef>> photos,
  }) async {
    final doc = pw.Document();
    final generatedAt = DateTime.now();
    doc.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(32)),
        footer: (context) => pw.Text(
          'Powered by ProtegeSaude, ${formatDateTimeBr(generatedAt)}',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
        build: (context) => [
          pw.Text(
            'Relatorio de Denuncia',
            style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text('Protocolo: $protocol'),
          pw.Text('Profissao: ${profession.nome}'),
          pw.Text(address.conselhoNome ?? 'Conselho Tutelar nao identificado'),
          pw.SizedBox(height: 18),
          _sectionTitle('Endereco e Conselho Tutelar'),
          _table([
            ['CEP', address.cep],
            ['Rua', address.rua],
            ['Numero', address.numero],
            ['Bairro', address.bairro],
            ['Cidade/UF', '${address.cidade}/${address.estado}'],
            ['Conselho Tutelar', address.conselhoNome ?? 'Nao identificado'],
            if (address.conselhoContato?.isNotEmpty == true)
              ['Contato', address.conselhoContato!],
          ]),
          for (final step in form.orderedSteps) ...[
            pw.SizedBox(height: 18),
            _sectionTitle(step.titulo),
            if (step.descricao?.trim().isNotEmpty == true)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text(step.descricao!),
              ),
            _table(
              step.campos.map((field) {
                final value = answers[step.id.toString()]?[field.id.toString()];
                final photoCount = photos[field.id.toString()]?.length ?? 0;
                return [
                  field.nome,
                  field.type == 'foto'
                      ? '$photoCount foto${photoCount == 1 ? '' : 's'}'
                      : _formatAnswer(field, value),
                ];
              }).toList(),
            ),
            for (final field in step.campos.where(
              (field) => field.type == 'foto',
            ))
              ..._photoWidgets(field, photos[field.id.toString()] ?? const []),
          ],
        ],
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final pdfDirectory = Directory(p.join(directory.path, 'denuncias'));
    if (!await pdfDirectory.exists()) {
      await pdfDirectory.create(recursive: true);
    }
    final file = File(p.join(pdfDirectory.path, 'denuncia_$protocol.pdf'));
    await file.writeAsBytes(await doc.save());
    return file.path;
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _table(List<List<String>> rows) {
    if (rows.isEmpty) {
      return pw.Text('Nenhuma informacao preenchida.');
    }
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: const {0: pw.FlexColumnWidth(2), 1: pw.FlexColumnWidth(3)},
      children: rows
          .map(
            (row) => pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                    row[0],
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(row[1].isEmpty ? '-' : row[1]),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  String _formatAnswer(PublicFormField field, Object? value) {
    if (value == null) {
      return '';
    }
    if (field.type == 'data') {
      return formatDateBr(value.toString());
    }
    if (field.type == 'checkbox') {
      return _labelsFor(field, value is List ? value : const []);
    }
    if (field.type == 'switch') {
      if (value is! Map) {
        return '';
      }
      final selected = value['selecionados'] is List
          ? _labelsFor(field, value['selecionados'] as List)
          : '';
      final boolValue = value['valor'];
      if (boolValue is! bool) {
        return '';
      }
      return boolValue ? 'Sim${selected.isEmpty ? '' : ': $selected'}' : 'Nao';
    }
    if (field.type == 'select' ||
        field.type == 'bairro' ||
        field.type == 'radio') {
      return _labelFor(field, value.toString());
    }
    return value.toString();
  }

  String _labelsFor(PublicFormField field, List<dynamic> values) {
    return values.map((value) => _labelFor(field, value.toString())).join(', ');
  }

  String _labelFor(PublicFormField field, String value) {
    for (final option in field.opcoes) {
      if (option.valor == value) {
        return option.label;
      }
    }
    return value;
  }

  List<pw.Widget> _photoWidgets(PublicFormField field, List<PhotoRef> photos) {
    if (photos.isEmpty) {
      return const [];
    }
    final widgets = <pw.Widget>[
      pw.SizedBox(height: 10),
      pw.Text(field.nome, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 6),
    ];
    for (final photo in photos) {
      final file = File(photo.localPath);
      if (!file.existsSync()) {
        continue;
      }
      final bytes = file.readAsBytesSync();
      widgets.add(
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Image(
                pw.MemoryImage(bytes),
                fit: pw.BoxFit.contain,
                height: 220,
              ),
              pw.SizedBox(height: 3),
              pw.Text(photo.name, style: const pw.TextStyle(fontSize: 9)),
            ],
          ),
        ),
      );
    }
    return widgets;
  }
}
