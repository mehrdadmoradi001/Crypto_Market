import 'package:dio/dio.dart';
import '../../config/app_config.dart';

// این کلاس مسئول اضافه کردن apiKey به تمام درخواست‌هاست
class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // پارامترهای فعلی درخواست را کپی می‌کنیم
    final queryParameters = Map<String, dynamic>.from(options.queryParameters);

    // apiKey را به پارامترها اضافه می‌کنیم
    queryParameters['apiKey'] = AppConfig.config.apiKey;

    // پارامترهای جدید را به درخواست اعمال می‌کنیم
    options.queryParameters = queryParameters;

    // درخواست را به مرحله بعد ارسال می‌کنیم
    super.onRequest(options, handler);
  }
}