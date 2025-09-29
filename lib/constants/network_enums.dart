/// انواع خطاهای شبکه
enum NetworkErrorType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
  noInternetConnection,
  serverError,
  unauthorized,
  forbidden,
  notFound,
  badRequest,
}

/// انواع درخواست‌های HTTP
enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

/// وضعیت‌های مختلف شبکه
enum NetworkStatus {
  connected,
  disconnected,
  connecting,
  unknown,
}

/// انواع content type
enum ContentType {
  json('application/json'),
  formData('multipart/form-data'),
  formUrlEncoded('application/x-www-form-urlencoded');

  final String value;
  const ContentType(this.value);
}