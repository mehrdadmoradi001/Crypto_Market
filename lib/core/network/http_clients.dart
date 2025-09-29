abstract class HttpClients {

  Future<HttpClientsResponse> get(String url, {Map<String, dynamic>? queryParameters});


  Future<HttpClientsResponse> post(String url, {dynamic data}) async {
    throw UnimplementedError('POST method not implemented');
  }

  Future<HttpClientsResponse> put(String url, {dynamic data}) async {
    throw UnimplementedError('PUT method not implemented');
  }

  Future<HttpClientsResponse> delete(String url) async {
    throw UnimplementedError('DELETE method not implemented');
  }

  Future<HttpClientsResponse> patch(String url, {dynamic data}) async {
    throw UnimplementedError('PATCH method not implemented');
  }
}

abstract class HttpClientsResponse {
  dynamic get data;
  int get statusCode;
  Map<String, dynamic> get headers;
}