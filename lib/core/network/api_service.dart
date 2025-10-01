import 'http_clients.dart';

// این کلاس تنها مسئول ارتباط با API و دانستن endpoint ها است.
class ApiService {
  final HttpClients _httpClients;

  ApiService(this._httpClients);

  Future<dynamic> getAssets({String? query}) async {
    final Map<String, dynamic> queryParameters = {};
    if (query != null && query.isNotEmpty) {
      queryParameters['search'] = query;
    }
    // اینجا فقط endpoint ارسال می‌شود
    final response = await _httpClients.get('/assets', queryParameters: queryParameters);
    return response.data;
  }
}

// در آینده اگر endpoint دیگری داشتید، اینجا اضافه می‌کنید
// Future<dynamic> getAssetById(String id) async {
//   final response = await _httpClients.get('/assets/$id');
//   return response.data;
// }

