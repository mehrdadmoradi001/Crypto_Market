import '../../../../constants/api_constants.dart';
import '../../../../core/network/http_clients.dart';
import '../../domain/entities/crypto.dart';
import 'coin_remote_data_source.dart';

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource{

  final HttpClients httpClients;
  CoinRemoteDataSourceImpl({required this.httpClients});

  @override
  Future<List<Crypto>> getCoinList() async {
    try {
      final response = await httpClients.get(
          '${ApiConstants.assets}?apiKey=${ApiConstants.apiKey}'
      );

      final List<dynamic> data = response.data['data'];
      return data.map<Crypto>((json) => Crypto.fromMapJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch coins: $e');
    }
  }

}