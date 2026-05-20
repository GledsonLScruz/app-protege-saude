import 'dart:io';

import 'package:flutter/material.dart';

import '../../../shared/models/complaint_models.dart';
import '../../../shared/models/public_form.dart';
import '../../../shared/utils/date_utils.dart';
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
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text('Resumo', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Endereco e Conselho Tutelar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              _Info(label: 'CEP', value: address.cep),
              _Info(label: 'Rua', value: address.rua),
              _Info(label: 'Numero', value: address.numero),
              _Info(label: 'Bairro', value: address.bairro),
              _Info(
                label: 'Cidade/UF',
                value: '${address.cidade}/${address.estado}',
              ),
              _Info(
                label: 'Conselho Tutelar',
                value: address.conselhoNome ?? 'Nao identificado',
              ),
              if (address.conselhoContato?.isNotEmpty == true)
                _Info(label: 'Contato', value: address.conselhoContato!),
            ],
          ),
        ),
        const SizedBox(height: 12),
        for (final step in form.orderedSteps) ...[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.titulo,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (step.descricao?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(step.descricao!),
                ],
                const Divider(height: 20),
                for (final field in step.campos)
                  _Info(
                    label: field.nome,
                    value: field.type == 'foto'
                        ? '${photos[field.id.toString()]?.length ?? 0} foto(s)'
                        : _formatAnswer(
                            field,
                            answers[step.id.toString()]?[field.id.toString()],
                          ),
                  ),
                for (final field in step.campos.where(
                  (field) => field.type == 'foto',
                ))
                  _PhotoPreview(
                    photos: photos[field.id.toString()] ?? const [],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  String _formatAnswer(PublicFormField field, Object? value) {
    if (value == null) {
      return '-';
    }
    if (field.type == 'data') {
      return formatDateBr(value.toString());
    }
    if (field.type == 'checkbox') {
      return _labels(field, value is List ? value : const []);
    }
    if (field.type == 'switch') {
      if (value is! Map || value['valor'] is! bool) {
        return '-';
      }
      final selected = value['selecionados'] is List
          ? _labels(field, value['selecionados'] as List)
          : '';
      return value['valor'] == true
          ? 'Sim${selected.isEmpty ? '' : ': $selected'}'
          : 'Nao';
    }
    if (field.type == 'select' ||
        field.type == 'bairro' ||
        field.type == 'radio') {
      return _label(field, value.toString());
    }
    return value.toString().trim().isEmpty ? '-' : value.toString();
  }

  String _labels(PublicFormField field, List<dynamic> values) {
    return values.map((value) => _label(field, value.toString())).join(', ');
  }

  String _label(PublicFormField field, String value) {
    for (final option in field.opcoes) {
      if (option.valor == value) {
        return option.label;
      }
    }
    return value;
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
          Text(value.trim().isEmpty ? '-' : value),
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
