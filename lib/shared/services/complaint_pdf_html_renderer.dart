import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mime/mime.dart';

import '../models/complaint_models.dart';
import 'complaint_summary_builder.dart';

class ComplaintPdfTemplate {
  const ComplaintPdfTemplate({required this.html, required this.css});

  final String html;
  final String css;
}

class ComplaintPdfPhoto {
  const ComplaintPdfPhoto({required this.name, required this.dataUrl});

  final String name;
  final String dataUrl;
}

class ComplaintPdfPhotoGroup {
  const ComplaintPdfPhotoGroup({
    required this.label,
    required this.photos,
    required this.emptyText,
  });

  final String label;
  final List<ComplaintPdfPhoto> photos;
  final String emptyText;
}

Future<ComplaintPdfTemplate> loadComplaintPdfTemplate() async {
  final html = await rootBundle.loadString(
    'assets/templates/complaint_pdf/complaint-pdf-template.html',
  );
  final css = await rootBundle.loadString(
    'assets/templates/complaint_pdf/complaint-pdf-template.css',
  );

  return ComplaintPdfTemplate(html: html, css: css);
}

Future<List<ComplaintPdfPhoto>> buildComplaintPdfPhotos(
  List<PhotoRef> photos,
) async {
  final result = <ComplaintPdfPhoto>[];
  for (final photo in photos) {
    final file = File(photo.localPath);
    if (!await file.exists()) {
      continue;
    }
    final bytes = await file.readAsBytes();
    final mimeType = _imageMimeType(photo, bytes);
    if (mimeType == null) {
      continue;
    }
    result.add(
      ComplaintPdfPhoto(
        name: photo.name,
        dataUrl: 'data:$mimeType;base64,${base64Encode(bytes)}',
      ),
    );
  }
  return result;
}

Future<String> buildComplaintPdfHtml({
  required String templateHtml,
  required String templateCss,
  required String generatedAt,
  required String professionName,
  required List<ComplaintSummarySection> sections,
}) async {
  final renderedSections = <String>[];
  for (final entry in sections.asMap().entries) {
    renderedSections.add(await renderSection(entry.value, entry.key));
  }

  return fillTemplate(templateHtml, {
    'styles': templateCss,
    'generatedAt': escapeHtml(generatedAt),
    'professionName': escapeHtml(professionName),
    'sections': renderedSections.join(''),
  });
}

String escapeHtml(String value) {
  return value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#39;');
}

String renderTextValue(String value) {
  return escapeHtml(value).replaceAll(RegExp(r'\r?\n'), '<br />');
}

String renderTextRows(List<ComplaintSummaryItem> items) {
  if (items.isEmpty) return '';

  final rows = items
      .map((item) {
        return '''
        <tr>
          <td>${escapeHtml(item.label)}</td>
          <td>${renderTextValue(item.value)}</td>
        </tr>
      ''';
      })
      .join('');

  return '''
    <table class="complaint-table">
      <thead>
        <tr>
          <th>Pergunta</th>
          <th>Resposta</th>
        </tr>
      </thead>
      <tbody>$rows</tbody>
    </table>
  ''';
}

bool isInlineImageSource(String value) {
  return value.startsWith('data:image/');
}

String renderPhotoGroup(ComplaintPdfPhotoGroup item) {
  final content = item.photos.isEmpty
      ? '<p class="complaint-photo-group__empty">${escapeHtml(item.emptyText)}</p>'
      : '''
        <div class="complaint-photo-grid">
          ${item.photos.map((photo) {
          final source = isInlineImageSource(photo.dataUrl) ? photo.dataUrl : '';

          return '''
                <figure class="complaint-photo-card">
                  <img src="$source" alt="${escapeHtml(photo.name)}" />
                  <figcaption>${escapeHtml(photo.name)}</figcaption>
                </figure>
              ''';
        }).join('')}
        </div>
      ''';

  return '''
    <div class="complaint-photo-group">
      <p class="complaint-photo-group__label">${escapeHtml(item.label)}</p>
      $content
    </div>
  ''';
}

Future<String> renderSection(ComplaintSummarySection section, int index) async {
  final textItems = section.items
      .where((item) => !item.isPhotoField)
      .toList(growable: false);
  final photoItems = section.items
      .where((item) => item.isPhotoField)
      .toList(growable: false);
  final photoGroups = <ComplaintPdfPhotoGroup>[];

  for (final item in photoItems) {
    photoGroups.add(
      ComplaintPdfPhotoGroup(
        label: item.label,
        photos: await buildComplaintPdfPhotos(item.photos),
        emptyText: 'Nenhuma foto anexada.',
      ),
    );
  }

  return '''
    <section class="complaint-section">
      <h2 class="complaint-section__title">
        <span class="complaint-section__number">${index + 1}</span>
        <span>${escapeHtml(section.title)}</span>
      </h2>
      ${renderTextRows(textItems)}
      ${photoGroups.map(renderPhotoGroup).join('')}
    </section>
  ''';
}

String fillTemplate(String templateHtml, Map<String, String> tokens) {
  return tokens.entries.fold(templateHtml, (html, entry) {
    return html.replaceAll('{{${entry.key}}}', entry.value);
  });
}

String? _imageMimeType(PhotoRef photo, List<int> bytes) {
  final declared = photo.mimeType.trim().toLowerCase();
  if (_isSupportedImageMimeType(declared)) {
    return declared;
  }
  final detected = lookupMimeType(photo.localPath, headerBytes: bytes);
  if (detected != null && _isSupportedImageMimeType(detected)) {
    return detected;
  }
  return null;
}

bool _isSupportedImageMimeType(String value) {
  return const {'image/jpeg', 'image/png', 'image/webp'}.contains(value);
}
