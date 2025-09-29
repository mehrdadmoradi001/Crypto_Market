import '../entities/crypto.dart';
import '../repositories/coin_repository.dart';

class SearchCoinsUseCase {
  final CoinRepository repository;

  SearchCoinsUseCase(this.repository);

  Future<List<Crypto>> call(String query) async {
    return await repository.searchCoins(query);
  }
}