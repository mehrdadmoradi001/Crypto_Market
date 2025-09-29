import '../entities/crypto.dart';

abstract class CoinRepository{
  Future<List<Crypto>> getCoinList();
  Future<List<Crypto>> searchCoins(String query);
}