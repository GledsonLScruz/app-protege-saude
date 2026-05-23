import '../models/complaint_models.dart';
import '../models/public_form.dart';
import '../utils/date_utils.dart';
import '../utils/text_normalizer.dart';

class DynamicFieldValidator {
  const DynamicFieldValidator();

  String? validateField(
    PublicFormField field,
    Object? value, {
    List<PhotoRef> photos = const [],
  }) {
    switch (field.type) {
      case 'texto':
      case 'textarea':
        return _validateRequiredText(field, value);
      case 'numero':
        return _validateNumber(field, value);
      case 'data':
        return _validateDate(field, value);
      case 'cep':
        return _validateCep(field, value);
      case 'select':
      case 'bairro':
      case 'radio':
        return _validateSingleOption(field, value);
      case 'checkbox':
        return _validateMultipleOptions(field, value);
      case 'switch':
        return _validateSwitch(field, value);
      case 'foto':
        return _validatePhotos(field, photos);
      default:
        return _validateRequiredText(field, value);
    }
  }

  bool isFieldValid(
    PublicFormField field,
    Object? value, {
    List<PhotoRef> photos = const [],
  }) => validateField(field, value, photos: photos) == null;

  String? _validateRequiredText(PublicFormField field, Object? value) {
    if (!field.isRequired) {
      return null;
    }
    return value?.toString().trim().isNotEmpty == true
        ? null
        : 'Campo obrigatório.';
  }

  String? _validateNumber(PublicFormField field, Object? value) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) {
      return field.isRequired ? 'Campo obrigatório.' : null;
    }
    return num.tryParse(text.replaceAll(',', '.')) == null
        ? 'Informe um número válido.'
        : null;
  }

  String? _validateDate(PublicFormField field, Object? value) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) {
      return field.isRequired ? 'Campo obrigatório.' : null;
    }
    final parsed = parseSimpleDate(text);
    if (parsed == null) {
      return 'Informe uma data válida.';
    }
    final label = normalizeLooseText('${field.nome} ${field.dica ?? ''}');
    if (label.contains('nascimento') && parsed.isAfter(DateTime.now())) {
      return 'A data de nascimento não pode ser futura.';
    }
    return null;
  }

  String? _validateCep(PublicFormField field, Object? value) {
    final digits = onlyDigits(value?.toString() ?? '');
    if (digits.isEmpty) {
      return field.isRequired ? 'Campo obrigatório.' : null;
    }
    return digits.length == 8 ? null : 'Informe um CEP válido.';
  }

  String? _validateSingleOption(PublicFormField field, Object? value) {
    final selected = value?.toString().trim() ?? '';
    if (selected.isEmpty) {
      return field.isRequired ? 'Selecione uma opção.' : null;
    }
    return _isAllowed(field, selected) ? null : 'Opção inválida.';
  }

  String? _validateMultipleOptions(PublicFormField field, Object? value) {
    final selected = _asStringList(value);
    if (selected.isEmpty) {
      return field.isRequired ? 'Selecione ao menos uma opção.' : null;
    }
    final invalid = selected.any((item) => !_isAllowed(field, item));
    return invalid ? 'Opção inválida.' : null;
  }

  String? _validateSwitch(PublicFormField field, Object? value) {
    final map = value is Map ? value : const {};
    final boolValue = map['valor'];
    if (boolValue is! bool) {
      return field.isRequired ? 'Informe Sim ou Não.' : null;
    }
    if (boolValue) {
      final selected = _asStringList(map['selecionados']);
      final allowed = field.conditionalOptions
          .map((option) => option.valor)
          .toList(growable: false);
      if (allowed.isNotEmpty &&
          selected.any((item) => !allowed.contains(item))) {
        return 'Opção inválida.';
      }
      if (field.validacoes?.opcoesCondicionaisAceitaMultiplos == false &&
          selected.length > 1) {
        return 'Selecione apenas uma opção.';
      }
    }
    return null;
  }

  String? _validatePhotos(PublicFormField field, List<PhotoRef> photos) {
    if (photos.isEmpty && field.isRequired) {
      return 'Adicione ao menos uma foto.';
    }
    final max = field.resolvedMaxPhotos;
    if (photos.length > max) {
      return max == 1
          ? 'Selecione no máximo 1 foto.'
          : 'Selecione no máximo $max fotos.';
    }
    return null;
  }

  bool _isAllowed(PublicFormField field, String value) {
    final allowedFromValidation =
        field.validacoes?.opcoesPermitidas ?? const [];
    final allowed = allowedFromValidation.isNotEmpty
        ? allowedFromValidation
        : field.opcoes.map((option) => option.valor).toList();
    return allowed.isEmpty || allowed.contains(value);
  }

  List<String> _asStringList(Object? value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return const [];
  }
}
