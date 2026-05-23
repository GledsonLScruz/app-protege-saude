import '../models/complaint_models.dart';
import '../models/public_form.dart';

ComplaintDraft sanitizeDraft(ComplaintDraft draft, PublicForm form) {
  final validStepIds = form.orderedSteps
      .map((step) => step.id.toString())
      .toSet();
  final validFieldIds = <String, Set<String>>{
    for (final step in form.orderedSteps)
      step.id.toString(): step.campos
          .map((field) => field.id.toString())
          .toSet(),
  };

  final answers = <String, Map<String, dynamic>>{};
  for (final entry in draft.dynamicAnswers.entries) {
    if (!validStepIds.contains(entry.key)) {
      continue;
    }
    final allowedFields = validFieldIds[entry.key] ?? const <String>{};
    answers[entry.key] = {
      for (final answer in entry.value.entries)
        if (allowedFields.contains(answer.key))
          answer.key: _normalizeValue(answer.value),
    };
  }

  final photos = <String, List<PhotoRef>>{};
  final validPhotoFieldIds = form.orderedSteps
      .expand((step) => step.campos)
      .where((field) => field.type == 'foto')
      .map((field) => field.id.toString())
      .toSet();
  for (final entry in draft.photoRefs.entries) {
    if (validPhotoFieldIds.contains(entry.key)) {
      photos[entry.key] = entry.value;
    }
  }

  return draft.copyWith(
    dynamicAnswers: answers,
    photoRefs: photos,
    updatedAt: DateTime.now(),
  );
}

Object? _normalizeValue(Object? value) {
  if (value is Map) {
    final normalized = value.map((key, val) => MapEntry(key.toString(), val));
    if (normalized.containsKey('valor')) {
      final rawSelected = normalized['selecionados'];
      return {
        'valor': normalized['valor'] is bool ? normalized['valor'] : null,
        'selecionados': rawSelected is List
            ? rawSelected.map((item) => item.toString()).toList()
            : <String>[],
      };
    }
    return normalized;
  }
  if (value is List) {
    return value.map((item) => item.toString()).toList();
  }
  return value;
}
