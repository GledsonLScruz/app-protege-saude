import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.cause});

  final String message;
  final int? statusCode;
  final Object? cause;

  @override
  String toString() => message;

  static ApiException fromDio(DioException error) {
    final data = error.response?.data;
    final message =
        _extractMessage(data) ??
        (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.sendTimeout
            ? 'Tempo de conexao esgotado. Verifique sua internet e tente novamente.'
            : 'Nao foi possivel conectar ao servidor. Verifique sua internet e tente novamente.');
    return ApiException(
      message,
      statusCode: error.response?.statusCode,
      cause: error,
    );
  }

  static String? _extractMessage(Object? data) {
    if (data is Map) {
      final value = data['mensagem'] ?? data['message'] ?? data['error'];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }
}
