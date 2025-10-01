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
    return await remoteDataSource.getCoinList(query: query);
  }
}
