abstract class BaseConfig {
  String get baseUrl;
  String get apiKey;
  Duration get connectTimeout;
  Duration get receiveTimeout;
}

class AppConfig {
  static late BaseConfig _config;

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

  static BaseConfig get config {
    return _config;
  }
}

enum Environment {
  dev,
  prod,
}

class DevConfig implements BaseConfig {
  @override
  String get baseUrl => "https://rest.coincap.io/v3";
  // String get baseUrl => "https://api.coincap.io/v2";

  @override
  String get apiKey => "658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25";
  // String get apiKey => "4a5a3b72af588f47da442719dea9e3dccbd5450d48d520a33bd17d7005b41702";

  @override
  Duration get connectTimeout => Duration(seconds: 20);

  @override
  Duration get receiveTimeout => Duration(seconds: 20);
}

class ProdConfig implements BaseConfig {
  @override
  String get baseUrl => "https://rest.coincap.io/v3";


  @override
  String get apiKey => "658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25";

  @override
  Duration get connectTimeout => Duration(seconds: 20);

  @override
  Duration get receiveTimeout => Duration(seconds: 20);
}