import '../constants/app_constants.dart';

class ApiConfig {
  const ApiConfig({required this.baseUrl});

  factory ApiConfig.fromEnvironment() {
    const value = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: AppConstants.defaultApiBaseUrl,
    );
    return ApiConfig(baseUrl: value);
  }

  final String baseUrl;

  String get origin {
    final uri = Uri.parse(baseUrl);
    return uri
        .replace(path: '', query: '', fragment: '')
        .toString()
        .replaceAll(RegExp(r'/$'), '');
  }

  static String normalizeBaseUrl(String rawValue) {
    final trimmed = rawValue.trim().isEmpty
        ? AppConstants.defaultApiBaseUrl
        : rawValue.trim();
    final withoutTrailingSlash = trimmed.replaceAll(RegExp(r'/+$'), '');
    if (withoutTrailingSlash.endsWith('/api')) {
      return withoutTrailingSlash;
    }
    return '$withoutTrailingSlash/api';
  }
}
