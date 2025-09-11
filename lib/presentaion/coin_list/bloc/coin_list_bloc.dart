import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc() : super(CoinListInitial()) {
    on<CoinListEvent>((event, emit) {
    });
  }
}
