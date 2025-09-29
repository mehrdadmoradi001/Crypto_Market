import '../../domain/entities/crypto.dart';

abstract class CoinRemoteDataSource{
  Future<List<Crypto>> getCoinList();
} 