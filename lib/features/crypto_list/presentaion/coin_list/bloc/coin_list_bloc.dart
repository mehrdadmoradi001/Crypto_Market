import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/network_exception.dart'; // Import NetworkException
import '../../../domain/entities/crypto.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../domain/usecases/get_coins_use_case.dart';
import '../../../domain/usecases/search_coins_use_case.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetCoinsUseCase _getCoinsUseCase = locator<GetCoinsUseCase>();
  final SearchCoinsUseCase _searchCoinsUseCase = locator<SearchCoinsUseCase>();

  CoinListBloc() : super(CoinListLoadingState()) {
    on<LoadInitialCoinDataEvent>(_onLoadInitialCoinData);
    on<RefreshCoinDataEvent>(_onRefreshCoinData);
    on<SearchCoinDataEvent>(_onSearchCoinData);
  }

  Future<void> _onLoadInitialCoinData(
      LoadInitialCoinDataEvent event,
      Emitter<CoinListState> emit,
      ) async {
    emit(CoinListLoadingState());
    try {
      debugPrint("5. BLoC is calling GetCoinsUseCase...");
      final cryptoList = await _getCoinsUseCase();
      debugPrint("6. BLoC received ${cryptoList.length} items. Emitting SuccessState.");
      emit(CoinListSuccessState(cryptoList));
    } on NetworkException catch (e) { // Catch specific exception
      emit(CoinListFailedState(e.message)); // Pass the user-friendly message
    } catch (e, stackTrace) {
      debugPrint("!!! ERROR reached BLoC: $e");
      debugPrint(stackTrace.toString());
      if (kDebugMode) {
        print('An unexpected error occurred in CoinListBloc: $e');
        print(stackTrace);
      }
      emit(CoinListFailedState('An unexpected error occurred.'));
    }
  }

  Future<void> _onRefreshCoinData(
      RefreshCoinDataEvent event,
      Emitter<CoinListState> emit,
      ) async {
    try {
      final cryptoList = await _getCoinsUseCase();
      emit(CoinListSuccessState(cryptoList));
    } on NetworkException catch (e) {
      emit(CoinListFailedState(e.message));
    } catch (e) {
      emit(CoinListFailedState('An unexpected error occurred.'));
    }
  }

  Future<void> _onSearchCoinData(
      SearchCoinDataEvent event,
      Emitter<CoinListState> emit,
      ) async {
    emit(CoinListLoadingState());
    try {
      final cryptoList = await _searchCoinsUseCase(params: SearchParams(event.query));
      emit(CoinListSuccessState(cryptoList));
    } on NetworkException catch (e) {
      emit(CoinListFailedState(e.message));
    } catch (e) {
      emit(CoinListFailedState('An unexpected error occurred.'));
    }
  }
}