import 'package:dio/dio.dart';
import '../../config/app_config.dart';

/*
class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // اضافه کردن کلید به Header به عنوان Bearer Token
    options.headers['Authorization'] = 'Bearer ${AppConfig.config.apiKey}';

    super.onRequest(options, handler);
  }
}*/

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${AppConfig.config.apiKey}';
    options.queryParameters.remove('apiKey');
    super.onRequest(options, handler);
  }
}
