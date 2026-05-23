import 'dart:io';

import 'package:flutter/material.dart';

import '../../../shared/models/complaint_models.dart';
import '../../../shared/models/public_form.dart';
import '../../../shared/services/complaint_summary_builder.dart';
import '../../../shared/widgets/section_card.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({
    super.key,
    required this.address,
    required this.form,
    required this.answers,
    required this.photos,
  });

  final ComplaintAddress address;
  final PublicForm form;
  final Map<String, Map<String, dynamic>> answers;
  final Map<String, List<PhotoRef>> photos;

  @override
  Widget build(BuildContext context) {
    const summaryBuilder = ComplaintSummaryBuilder();
    final sections = summaryBuilder.build(
      address: address,
      form: form,
      answers: answers,
      photos: photos,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text('Resumo', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        for (final section in sections) ...[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(height: 20),
                for (final item in section.items) ...[
                  _Info(label: item.label, value: item.value),
                  _PhotoPreview(photos: item.photos),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            value.trim().isEmpty
                ? ComplaintSummaryBuilder.emptyValueText
                : value,
          ),
        ],
      ),
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.photos});

  final List<PhotoRef> photos;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        for (final photo in photos)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(photo.localPath),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}
