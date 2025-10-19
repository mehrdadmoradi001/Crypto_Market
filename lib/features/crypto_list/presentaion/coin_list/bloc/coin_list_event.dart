part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialCoinDataEvent extends CoinListEvent {}
class RefreshCoinDataEvent extends CoinListEvent {}
class SearchCoinDataEvent extends CoinListEvent {
  final String query;
  SearchCoinDataEvent(this.query);

  @override
  List<Object> get props => [query];
}
