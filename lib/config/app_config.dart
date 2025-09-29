// lib/config/app_config.dart

// یک کلاس abstract برای مقادیر ثابت برنامه
abstract class BaseConfig {
  String get baseUrl;
  String get apiKey;
  Duration get connectTimeout;
  Duration get receiveTimeout;
}

// کلاسی که کانفیگ فعال را نگه می‌دارد
class AppConfig {
  static late BaseConfig _config;

  // تابعی برای تنظیم کانفیگ بر اساس محیط
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = DevConfig();
        break;
      case Environment.prod:
        _config = ProdConfig();
        break;
    }
  }

  // Getter برای دسترسی به کانفیگ فعال
  static BaseConfig get config {
    return _config;
  }
}

// enum برای تعریف محیط‌های مختلف
enum Environment {
  dev,
  prod,
}

// پیاده‌سازی کانفیگ برای محیط توسعه (Development)
class DevConfig implements BaseConfig {
  @override
  String get baseUrl => "https://rest.coincap.io/v3"; // آدرس تست

  @override
  String get apiKey => "YOUR_DEV_API_KEY";

  @override
  // TODO: implement connectTimeout
  Duration get connectTimeout => throw UnimplementedError();

  @override
  // TODO: implement receiveTimeout
  Duration get receiveTimeout => throw UnimplementedError(); // کلید تست شما
}

// پیاده‌سازی کانفیگ برای محیط پروداکشن (Production)
class ProdConfig implements BaseConfig {
  @override
  String get baseUrl => "https://api.production.com/v1"; // آدرس اصلی

  @override
  String get apiKey => "YOUR_PRODUCTION_API_KEY";

  @override
  // TODO: implement connectTimeout
  Duration get connectTimeout => throw UnimplementedError();

  @override
  // TODO: implement receiveTimeout
  Duration get receiveTimeout => throw UnimplementedError(); // کلید اصلی شما
}