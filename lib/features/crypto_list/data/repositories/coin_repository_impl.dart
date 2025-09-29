import '../../domain/entities/crypto.dart';
import '../../domain/repositories/coin_repository.dart';
import '../datasource/coin_remote_data_source.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteDataSource remoteDataSource;

  CoinRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Crypto>> getCoinList() async {
    return await remoteDataSource.getCoinList();
  }

  @override
  Future<List<Crypto>> searchCoins(String query) async {
    final allCoins = await remoteDataSource.getCoinList();

    if (query.isEmpty) {
      return allCoins;
    }

    final lowercaseQuery = query.toLowerCase();
    return allCoins
        .where((coin) =>
            coin.name.toLowerCase().contains(lowercaseQuery) ||
            coin.symbol.toLowerCase().contains(lowercaseQuery) ||
            coin.id.toLowerCase().contains(lowercaseQuery))
        .toList();
  }
}
