part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListState {}

final class CoinListLoadingState extends CoinListState {}

final class CoinListSuccessState extends CoinListState {
  final List<Crypto> cryptoList;
  CoinListSuccessState(this.cryptoList);
}
final class CoinListFailedState extends CoinListState {
  final String errorMessage;
  CoinListFailedState(this.errorMessage);
}
