import '../entities/crypto.dart';
import '../repositories/coin_repository.dart';

class GetCoinsUseCase {
  final CoinRepository repository;

  GetCoinsUseCase(this.repository);

  Future<List<Crypto>> call() async {
    return await repository.getCoinList();
  }
}
