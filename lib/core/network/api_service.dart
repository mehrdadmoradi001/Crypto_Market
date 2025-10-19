import 'http_clients.dart';

// این کلاس تنها مسئول ارتباط با API و دانستن endpoint ها است.
class ApiService {
  final HttpClients _httpClients;

  ApiService(this._httpClients);



  Future<dynamic> getAssets({Map<String, dynamic>? queryParameters}) async {
    // دیگر منطق جستجو در اینجا نیست، فقط درخواست را ارسال می‌کنیم
    final response = await _httpClients.get('/assets', queryParameters: queryParameters);
    return response.data;
  }


/// [DEPRECATED] - این متد با نسخه جدیدتر که یک Map دریافت می‌کند، جایگزین شده است.
//
// **دلیل تغییر و معماری:**
/// این نسخه قبلی، مسئولیت ساخت پارامترهای جستجو ('search') را بر عهده داشت.
/// طبق اصول معماری پاک (Clean Architecture) و اصل مسئولیت واحد (SRP)،
/// کلاس ApiService نباید از جزئیات و پارامترهای مورد نیاز یک endpoint خاص (مانند نحوه جستجو یا احراز هویت) آگاه باشد.
//
// **راه حل جدید:**
/// 1. یک متد عمومی‌تر ساخته شد که یک Map<String, dynamic> برای queryParameters دریافت می‌کند.
/// 2. مسئولیت ساخت این Map (که اکنون شامل 'apiKey' برای API v3 و 'search' است) به لایه بالاتر یعنی 'CoinRemoteDataSourceImpl' منتقل شد.
//
/// این کار باعث جداسازی بهتر مسئولیت‌ها و تمیزتر شدن لایه شبکه می‌شود.
/*  Future<dynamic> getAssets({String? query}) async {
    final Map<String, dynamic> queryParameters = {};
    if (query != null && query.isNotEmpty) {
      queryParameters['search'] = query;
    }
    // اینجا فقط endpoint ارسال می‌شود
    final response = await _httpClients.get('/assets', queryParameters: queryParameters);
    return response.data;
  }*/
}

// در آینده اگر endpoint دیگری داشتید، اینجا اضافه می‌کنید
// Future<dynamic> getAssetById(String id) async {
//   final response = await _httpClients.get('/assets/$id');
//   return response.data;
// }

