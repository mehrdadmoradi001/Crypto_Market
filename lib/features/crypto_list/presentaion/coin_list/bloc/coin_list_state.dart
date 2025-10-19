part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListState extends Equatable{
  const CoinListState();

  ///یک خروجی خوانا و معنادار شامل نام کلاس و تمام پراپرتی‌هایی که در props لیست کرده‌اید، تولید کند.
  @override
  bool get stringify => true;

  @override
  final List<Object> props = const [];
}

final class CoinListLoadingState extends CoinListState {}

final class CoinListSuccessState extends CoinListState {
  final List<Crypto> cryptoList;
  CoinListSuccessState(this.cryptoList);
  @override
  List<Object> get props => [cryptoList];
}

final class CoinListFailedState extends CoinListState {
  final String errorMessage;
  CoinListFailedState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
