import '../models/complaint_models.dart';
import '../models/public_form.dart';
import '../utils/date_utils.dart';
import '../utils/display_text.dart';

class ComplaintSummarySection {
  const ComplaintSummarySection({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<ComplaintSummaryItem> items;
}

class ComplaintSummaryItem {
  const ComplaintSummaryItem({
    required this.fieldKey,
    required this.label,
    required this.value,
    this.photos = const [],
    this.isPhotoField = false,
  });

  final String fieldKey;
  final String label;
  final String value;
  final List<PhotoRef> photos;
  final bool isPhotoField;

  bool get isPhoto =>
      isPhotoField || photos.isNotEmpty || value.contains('foto');
}

class ComplaintSummaryBuilder {
  const ComplaintSummaryBuilder();

  static const emptyValueText = 'Não informado';

  List<ComplaintSummarySection> build({
    required ComplaintAddress address,
    required PublicForm form,
    required Map<String, Map<String, dynamic>> answers,
    required Map<String, List<PhotoRef>> photos,
  }) {
    return [
      ComplaintSummarySection(
        id: 'victim_address',
        title: 'Endereço e Conselho Tutelar',
        items: [
          _item('victim.zipCode', 'CEP', address.cep),
          _item('victim.street', 'Rua', address.rua),
          _item('victim.number', 'Número', address.numero),
          _item('victim.neighborhood', 'Bairro', address.bairro),
          _item('victim.cityState', 'Cidade/UF', _cityState(address)),
          _item(
            'victim.guardianshipCouncil',
            'Conselho Tutelar',
            address.conselhoNome,
          ),
          if (address.conselhoContato?.trim().isNotEmpty == true)
            _item('victim.councilContact', 'Contato', address.conselhoContato),
        ],
      ),
      for (final step in form.orderedSteps)
        ComplaintSummarySection(
          id: 'step.${step.id}',
          title: accentPortugueseText(step.titulo),
          items: [
            for (final field in step.campos)
              _fieldItem(
                step: step,
                field: field,
                value: answers[step.id.toString()]?[field.id.toString()],
                photos: photos[field.id.toString()] ?? const [],
              ),
          ],
        ),
    ];
  }

  ComplaintSummaryItem _fieldItem({
    required PublicFormStep step,
    required PublicFormField field,
    required Object? value,
    required List<PhotoRef> photos,
  }) {
    final fieldKey = 'step.${step.id}.field.${field.id}';
    if (field.type == 'foto') {
      return ComplaintSummaryItem(
        fieldKey: fieldKey,
        label: accentPortugueseText(field.nome),
        value: _photoCount(photos.length),
        photos: photos,
        isPhotoField: true,
      );
    }
    return _item(
      fieldKey,
      accentPortugueseText(field.nome),
      _formatAnswer(field, value),
    );
  }

  ComplaintSummaryItem _item(String fieldKey, String label, Object? value) {
    return ComplaintSummaryItem(
      fieldKey: fieldKey,
      label: label,
      value: _normalizeValue(value),
    );
  }

  String _formatAnswer(PublicFormField field, Object? value) {
    if (value == null) {
      return emptyValueText;
    }
    if (field.type == 'data') {
      return formatDateBr(value.toString());
    }
    if (field.type == 'checkbox') {
      return _labels(field, value is List ? value : const []);
    }
    if (field.type == 'switch') {
      if (value is! Map || value['valor'] is! bool) {
        return emptyValueText;
      }
      final selectedValues = value['selecionados'] is List
          ? value['selecionados'] as List
          : const [];
      final selected = selectedValues.isEmpty
          ? ''
          : _labels(field, selectedValues);
      return value['valor'] == true
          ? 'Sim${selected.isEmpty ? '' : ': $selected'}'
          : 'Não';
    }
    if (field.type == 'select' ||
        field.type == 'bairro' ||
        field.type == 'radio') {
      return accentPortugueseText(_label(field, value.toString()));
    }
    return value.toString();
  }

  String _labels(PublicFormField field, List<dynamic> values) {
    if (values.isEmpty) {
      return emptyValueText;
    }
    return values
        .map((value) => accentPortugueseText(_label(field, value.toString())))
        .join(', ');
  }

  String _label(PublicFormField field, String value) {
    for (final option in field.opcoes) {
      if (option.valor == value) {
        return accentPortugueseText(option.label);
      }
    }
    return value;
  }

  String _normalizeValue(Object? value) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? emptyValueText : text;
  }

  String _cityState(ComplaintAddress address) {
    if (address.cidade.trim().isEmpty && address.estado.trim().isEmpty) {
      return emptyValueText;
    }
    if (address.cidade.trim().isEmpty) {
      return address.estado;
    }
    if (address.estado.trim().isEmpty) {
      return address.cidade;
    }
    return '${address.cidade}/${address.estado}';
  }

  String _photoCount(int count) {
    if (count == 0) {
      return emptyValueText;
    }
    return count == 1 ? '1 foto' : '$count fotos';
  }
}
