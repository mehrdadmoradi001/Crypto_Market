import 'http_clients.dart';

// این کلاس تنها مسئول ارتباط با API و دانستن endpoint ها است.
class ApiService {
  final HttpClients _httpClients;

  ApiService(this._httpClients);

  // یک متد برای هر endpoint تعریف می‌کنیم
  Future<dynamic> getAssets() async {
    // تمام جزئیات فراخوانی در اینجا کپسوله می‌شود
    final response = await _httpClients.get('/assets');
    return response.data; // فقط دیتا را برمی‌گردانیم
  }

// در آینده اگر endpoint دیگری داشتید، اینجا اضافه می‌کنید
// Future<dynamic> getAssetById(String id) async {
//   final response = await _httpClients.get('/assets/$id');
//   return response.data;
// }
}
