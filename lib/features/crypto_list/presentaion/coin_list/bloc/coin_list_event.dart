part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListEvent {}

class LoadInitialCoinDataEvent extends CoinListEvent {}
class RefreshCoinDataEvent extends CoinListEvent {}
class SearchCoinDataEvent extends CoinListEvent {
  final String query;
  SearchCoinDataEvent(this.query);
}
