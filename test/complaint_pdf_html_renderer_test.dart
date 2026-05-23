import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/services/complaint_pdf_html_renderer.dart';
import 'package:protege_saude/shared/services/complaint_summary_builder.dart';

void main() {
  test('renderer escapa texto e preserva quebras de linha', () async {
    final html = await buildComplaintPdfHtml(
      templateHtml: '{{professionName}}{{generatedAt}}{{sections}}',
      templateCss: '.unused {}',
      generatedAt: '21/05/2026',
      professionName: 'Odonto & Saúde',
      sections: const [
        ComplaintSummarySection(
          id: 's1',
          title: 'Dados <iniciais>',
          items: [
            ComplaintSummaryItem(
              fieldKey: 'field.1',
              label: 'Descrição',
              value: 'Linha 1\n<script>alert("x")</script>',
            ),
          ],
        ),
      ],
    );

    expect(html, contains('Odonto &amp; Saúde'));
    expect(html, contains('21/05/2026'));
    expect(html, contains('Dados &lt;iniciais&gt;'));
    expect(
      html,
      contains(
        'Linha 1<br />&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      ),
    );
    expect(html, isNot(contains('<script>')));
  });

  test(
    'renderer transforma fotos locais em data URL e renderiza vazio',
    () async {
      final directory = Directory.systemTemp.createTempSync(
        'protege_pdf_html_',
      );
      addTearDown(() async {
        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      });
      final file = File('${directory.path}/foto.jpg');
      await file.writeAsBytes([1, 2, 3]);

      final html = await renderSection(
        ComplaintSummarySection(
          id: 's1',
          title: 'Evidências',
          items: [
            ComplaintSummaryItem(
              fieldKey: 'field.1',
              label: 'Fotos',
              value: '1 foto',
              photos: [
                PhotoRef(
                  id: 'photo-1',
                  name: 'foto & detalhe.jpg',
                  mimeType: 'image/jpeg',
                  sizeBytes: 3,
                  localPath: file.path,
                  createdAt: DateTime(2026, 5, 21),
                ),
              ],
              isPhotoField: true,
            ),
            const ComplaintSummaryItem(
              fieldKey: 'field.2',
              label: 'Sem foto',
              value: 'Não informado',
              isPhotoField: true,
            ),
          ],
        ),
        0,
      );

      expect(html, contains('data:image/jpeg;base64,AQID'));
      expect(html, contains('foto &amp; detalhe.jpg'));
      expect(html, contains('Nenhuma foto anexada.'));
      expect(html, isNot(contains('<td>Fotos</td>')));
    },
  );
}
