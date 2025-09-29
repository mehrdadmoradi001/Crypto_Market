import '../../../../core/usecase/usecase.dart';
import '../entities/crypto.dart';
import '../repositories/coin_repository.dart';

class SearchCoinsUseCase implements UseCase<List<Crypto>, SearchParams> {
  final CoinRepository repository;

  SearchCoinsUseCase(this.repository);

  Future<List<Crypto>> call({SearchParams? params}) async {
    return await repository.searchCoins(params!.query);
  }
}

class SearchParams {
  final String query;
  SearchParams(this.query);
}