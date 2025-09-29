
import 'package:dio/dio.dart';

import '../../constants/network_enums.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final NetworkErrorType errorType;

  NetworkException({
    required this.message,
    this.statusCode,
    this.errorCode,
    required this.errorType,
  });

  @override
  String toString() => 'NetworkException: $message (Type: $errorType)${statusCode != null ? ' (Status: $statusCode)' : ''}';

  factory NetworkException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Request timeout - Please check your internet connection',
          statusCode: 408,
          errorType: NetworkErrorType.connectionTimeout,
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _getErrorMessageFromResponse(e.response);
        final errorType = _getErrorTypeFromStatusCode(statusCode);
        return NetworkException(
          message: message,
          statusCode: statusCode,
          errorType: errorType,
        );

      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          errorType: NetworkErrorType.cancel,
        );

      case DioExceptionType.unknown:
        if (e.error?.toString().contains('SocketException') == true) {
          return NetworkException(
            message: 'No internet connection',
            errorType: NetworkErrorType.noInternetConnection,
          );
        }
        return NetworkException(
          message: 'Unknown network error: ${e.error}',
          errorType: NetworkErrorType.unknown,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'SSL certificate error',
          errorType: NetworkErrorType.badCertificate,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'Connection error - Please check your internet',
          errorType: NetworkErrorType.connectionError,
        );

      }
  }

  static NetworkErrorType _getErrorTypeFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return NetworkErrorType.badRequest;
      case 401:
        return NetworkErrorType.unauthorized;
      case 403:
        return NetworkErrorType.forbidden;
      case 404:
        return NetworkErrorType.notFound;
      case 500:
      case 502:
      case 503:
        return NetworkErrorType.serverError;
      default:
        return NetworkErrorType.unknown;
    }
  }

  static String _getErrorMessageFromResponse(Response? response) {
    if (response == null) return 'Server error - No response';

    try {
      final dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        return data['message'] ?? data['error'] ?? 'Server error ${response.statusCode}';
      }
      if (data is String) {
        return data.isNotEmpty ? data : 'Server error ${response.statusCode}';
      }
    } catch (e) {
      // If parsing fails, use status code
    }

    switch (response.statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized - Please login again';
      case 403:
        return 'Forbidden - Access denied';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Server error ${response.statusCode}';
    }
  }
}