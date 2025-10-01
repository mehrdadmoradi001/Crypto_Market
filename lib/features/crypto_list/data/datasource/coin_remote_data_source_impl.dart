import '../../../../core/network/api_service.dart';
import '../../../../core/network/http_clients.dart';
import '../../domain/entities/crypto.dart';
import 'coin_remote_data_source.dart';

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  final ApiService _apiService;
  CoinRemoteDataSourceImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<List<Crypto>> getCoinList({String? query}) async {
    try {
      final response = await _apiService.getAssets(query: query);

      final List<dynamic> data = response['data'];
      return data.map<Crypto>((json) => Crypto.fromMapJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch coins: $e');
    }
  }
}