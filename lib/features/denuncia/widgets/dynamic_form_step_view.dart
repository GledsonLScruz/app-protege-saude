// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/models/complaint_models.dart';
import '../../../shared/models/public_form.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/text_normalizer.dart';
import '../../../shared/widgets/searchable_select.dart';

class DynamicFormStepView extends StatelessWidget {
  const DynamicFormStepView({
    super.key,
    required this.step,
    required this.color,
    required this.answerFor,
    required this.errorFor,
    required this.photosFor,
    required this.onChanged,
    required this.onAddGallery,
    required this.onCapture,
    required this.onRemovePhoto,
  });

  final PublicFormStep step;
  final Color color;
  final Object? Function(PublicFormField field) answerFor;
  final String? Function(PublicFormField field) errorFor;
  final List<PhotoRef> Function(PublicFormField field) photosFor;
  final void Function(PublicFormField field, Object? value) onChanged;
  final Future<String?> Function(PublicFormField field) onAddGallery;
  final Future<String?> Function(PublicFormField field) onCapture;
  final Future<void> Function(PublicFormField field, PhotoRef photo)
  onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text(step.titulo, style: Theme.of(context).textTheme.titleLarge),
        if (step.descricao?.trim().isNotEmpty == true) ...[
          const SizedBox(height: 8),
          Text(step.descricao!),
        ],
        const SizedBox(height: 20),
        for (final field in step.campos) ...[
          _FieldShell(
            field: field,
            error: errorFor(field),
            child: _fieldWidget(context, field),
          ),
          const SizedBox(height: 18),
        ],
      ],
    );
  }

  Widget _fieldWidget(BuildContext context, PublicFormField field) {
    final value = answerFor(field);
    return switch (field.type) {
      'texto' => _textField(field, value),
      'textarea' => _textField(field, value, maxLines: 5),
      'numero' => _textField(
        field,
        value,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      'data' => _dateField(context, field, value),
      'cep' => _textField(
        field,
        formatCep(value?.toString() ?? ''),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          _CepInputFormatter(),
        ],
      ),
      'select' || 'bairro' => _selectField(field, value),
      'radio' => _radioField(field, value),
      'checkbox' => _checkboxField(field, value),
      'switch' => _switchField(field, value),
      'foto' => _photoField(context, field),
      _ => _textField(field, value),
    };
  }

  Widget _textField(
    PublicFormField field,
    Object? value, {
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      key: ValueKey('${field.id}_${field.type}'),
      initialValue: value?.toString() ?? '',
      minLines: maxLines > 1 ? maxLines : null,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: field.dica?.trim().isNotEmpty == true
            ? field.dica
            : 'Digite sua resposta',
      ),
      onChanged: (text) => onChanged(field, text),
    );
  }

  Widget _dateField(
    BuildContext context,
    PublicFormField field,
    Object? value,
  ) {
    final text = formatDateBr(value?.toString());
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final selected = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(value?.toString() ?? '') ?? now,
          firstDate: DateTime(now.year - 120),
          lastDate: DateTime(now.year + 5),
        );
        if (selected != null) {
          onChanged(field, simpleIsoDate(selected));
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.calendar_month_rounded),
          hintText: 'Selecione uma data',
        ),
        child: Text(text.isEmpty ? 'Selecione uma data' : text),
      ),
    );
  }

  Widget _selectField(PublicFormField field, Object? value) {
    FormOption? selected;
    for (final option in field.opcoes) {
      if (option.valor == value?.toString()) {
        selected = option;
        break;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.type == 'bairro' &&
            (field.validacoes?.opcoesPermitidas.isNotEmpty ?? false))
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Chip(
              visualDensity: VisualDensity.compact,
              label: const Text('Bairro validado'),
              avatar: Icon(Icons.verified_rounded, color: color, size: 18),
            ),
          ),
        SearchableSelect<FormOption>(
          label: 'Selecione',
          items: field.opcoes,
          itemLabel: (option) => option.label,
          value: selected,
          onSelected: (option) => onChanged(field, option.valor),
        ),
      ],
    );
  }

  Widget _radioField(PublicFormField field, Object? value) {
    return Column(
      children: field.opcoes
          .map(
            (option) => RadioListTile<String>(
              value: option.valor,
              groupValue: value?.toString(),
              onChanged: (selected) => onChanged(field, selected),
              title: Text(option.label),
              activeColor: color,
              contentPadding: EdgeInsets.zero,
            ),
          )
          .toList(),
    );
  }

  Widget _checkboxField(PublicFormField field, Object? value) {
    final selected = value is List
        ? value.map((item) => item.toString()).toSet()
        : <String>{};
    return Column(
      children: field.opcoes.map((option) {
        final checked = selected.contains(option.valor);
        return CheckboxListTile(
          value: checked,
          onChanged: (enabled) {
            final updated = {...selected};
            if (enabled ?? false) {
              updated.add(option.valor);
            } else {
              updated.remove(option.valor);
            }
            onChanged(field, updated.toList());
          },
          title: Text(option.label),
          activeColor: color,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }

  Widget _switchField(PublicFormField field, Object? value) {
    final map = value is Map ? value : const {};
    final boolValue = map['valor'] is bool ? map['valor'] as bool : null;
    final selected = map['selecionados'] is List
        ? (map['selecionados'] as List).map((item) => item.toString()).toSet()
        : <String>{};
    final conditionalOptions = field.conditionalOptions;
    void setSwitch(bool enabled) {
      onChanged(field, {'valor': enabled, 'selecionados': <String>[]});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: boolValue ?? false,
          onChanged: setSwitch,
          title: Text(boolValue == true ? 'Sim' : 'Nao'),
          activeThumbColor: color,
          contentPadding: EdgeInsets.zero,
        ),
        if (boolValue == true && conditionalOptions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.35)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: conditionalOptions.map((option) {
                final checked = selected.contains(option.valor);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (enabled) {
                    final updated = {...selected};
                    if (enabled ?? false) {
                      updated.add(option.valor);
                    } else {
                      updated.remove(option.valor);
                    }
                    onChanged(field, {
                      'valor': true,
                      'selecionados': updated.toList(),
                    });
                  },
                  title: Text(option.label),
                  activeColor: color,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _photoField(BuildContext context, PublicFormField field) {
    final photos = photosFor(field);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7E1DE)),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF8FAF9),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${photos.length}/${field.resolvedMaxPhotos} fotos selecionadas',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  final message = await onCapture(field);
                  if (context.mounted) {
                    _showPhotoMessage(context, message);
                  }
                },
                icon: const Icon(Icons.photo_camera_rounded),
                label: const Text('Camera'),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  final message = await onAddGallery(field);
                  if (context.mounted) {
                    _showPhotoMessage(context, message);
                  }
                },
                icon: const Icon(Icons.photo_library_rounded),
                label: const Text('Galeria'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (photos.isEmpty)
            const Text('Nenhuma foto selecionada.')
          else
            Column(
              children: photos
                  .map(
                    (photo) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(photo.localPath),
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: Text('Imagem indisponivel.'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              photo.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () => onRemovePhoto(field, photo),
                                icon: const Icon(Icons.delete_outline_rounded),
                                label: const Text('Remover'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  void _showPhotoMessage(BuildContext context, String? message) {
    if (message == null) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatCep(onlyDigits(newValue.text));
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _FieldShell extends StatelessWidget {
  const _FieldShell({required this.field, required this.child, this.error});

  final PublicFormField field;
  final Widget child;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                field.nome,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            if (field.isRequired)
              Text(
                '*',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
        if (field.dica?.trim().isNotEmpty == true) ...[
          const SizedBox(height: 4),
          Text(field.dica!, style: Theme.of(context).textTheme.bodySmall),
        ],
        const SizedBox(height: 8),
        child,
        if (error != null) ...[
          const SizedBox(height: 6),
          Text(
            error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}
