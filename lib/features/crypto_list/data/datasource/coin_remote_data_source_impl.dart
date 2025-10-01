import 'package:flutter/cupertino.dart';

import '../../../../core/network/api_service.dart';
import '../../domain/entities/crypto.dart';
import 'coin_remote_data_source.dart';

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  final ApiService _apiService;
  CoinRemoteDataSourceImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<List<Crypto>> getCoinList({String? query}) async {
    try {
      debugPrint("1. Calling ApiService getAssets with query: $query");
      final response = await _apiService.getAssets(query: query);

      debugPrint("2. Response received in DataSource: $response");

      final List<dynamic> data = response['data'];
      debugPrint("3. Parsing ${data.length} items.");

      final result = data.map<Crypto>((json) => Crypto.fromMapJson(json)).toList();
      debugPrint("4. Parsing completed successfully.");
      return result;

    } catch (e, stackTrace) {
      debugPrint("!!! ERROR in CoinRemoteDataSourceImpl: $e");
      debugPrint(stackTrace.toString());
      // خطا را دوباره پرتاب می‌کنیم تا لایه‌های بالاتر آن را مدیریت کنند
      rethrow;
    }
  }
}