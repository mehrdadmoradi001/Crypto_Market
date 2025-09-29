import 'package:dio/dio.dart';
import 'http_clients.dart';
import 'network_exception.dart';


class DioHttpClient extends HttpClients {
  final Dio _dio;

  DioHttpClient({
    required String baseUrl,
    connectTimeout = const Duration(seconds: 15000),
    receiveTimeout = const Duration(seconds: 15000),
    List<Interceptor> interceptors = const [],
  }) : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
  )) {
    _dio.interceptors.addAll(interceptors);
  }

  @override
  Future<HttpClientsResponse> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return DioResponse(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<HttpClientsResponse> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return DioResponse(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}



class DioResponse implements HttpClientsResponse {
  final Response _response;

  DioResponse(this._response);

  @override
  dynamic get data => _response.data;

  @override
  int get statusCode => _response.statusCode!;

  @override
  Map<String, dynamic> get headers => _response.headers.map;
}