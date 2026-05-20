import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Color parseHexColor(String? value, {Color fallback = const Color(0xFF24786B)}) {
  final raw = value?.trim();
  if (raw == null || raw.isEmpty) {
    return fallback;
  }
  final normalized = raw.startsWith('#') ? raw.substring(1) : raw;
  if (!RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(normalized)) {
    return fallback;
  }
  return Color(int.parse('FF$normalized', radix: 16));
}

String normalizeHexColor(String? value) {
  final color = parseHexColor(value);
  final hex = color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2);
  return '#${hex.toUpperCase()}';
}

Color defaultProfessionColor() =>
    parseHexColor(AppConstants.defaultProfessionColor);
