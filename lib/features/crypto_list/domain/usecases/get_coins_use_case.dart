import '../../../../core/usecase/usecase.dart';
import '../entities/crypto.dart';
import '../repositories/coin_repository.dart';

class GetCoinsUseCase implements UseCase<List<Crypto>, NoParams> {
  final CoinRepository repository;

  GetCoinsUseCase(this.repository);

  Future<List<Crypto>> call({NoParams? params}) async {
    return await repository.getCoinList();
  }
}
