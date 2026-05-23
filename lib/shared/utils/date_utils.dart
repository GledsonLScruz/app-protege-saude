String simpleIsoDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

DateTime? parseSimpleDate(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) {
    return null;
  }

  final brMatch = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(text);
  if (brMatch != null) {
    final day = int.tryParse(brMatch.group(1)!);
    final month = int.tryParse(brMatch.group(2)!);
    final year = int.tryParse(brMatch.group(3)!);
    if (day == null || month == null || year == null) {
      return null;
    }
    final date = DateTime(year, month, day);
    return date.year == year && date.month == month && date.day == day
        ? date
        : null;
  }

  final isoMatch = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(text);
  if (isoMatch == null) {
    return null;
  }
  final year = int.tryParse(isoMatch.group(1)!);
  final month = int.tryParse(isoMatch.group(2)!);
  final day = int.tryParse(isoMatch.group(3)!);
  if (year == null || month == null || day == null) {
    return null;
  }
  final date = DateTime(year, month, day);
  return date.year == year && date.month == month && date.day == day
      ? date
      : null;
}

String formatDateBr(String? dateValue) {
  if (dateValue == null || dateValue.trim().isEmpty) {
    return '';
  }
  final date = parseSimpleDate(dateValue);
  if (date == null) {
    return dateValue;
  }
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

String formatDateTimeBr(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$day/$month/${date.year} $hour:$minute';
}
