import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/crypto.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc() : super(CoinListLoadingState()) {
    on<LoadInitialCoinDataEvent>((event, emit) async{
      emit(CoinListLoadingState());
        var response = await Dio().get('https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
        List<Crypto> cryptoList = response.data['data']
            .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
            .toList();

        if (response.statusCode == 200) {
          emit(CoinListSuccessState(cryptoList));
        } else {
          emit(CoinListFailedState(response.statusMessage!));
        }
    });

    on<RefreshCoinDataEvent>((event, emit) async{
      emit(CoinListLoadingState());
      var response = await Dio().get('https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
      List<Crypto> cryptoList = response.data['data']
          .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
          .toList();

      if (response.statusCode == 200) {
        emit(CoinListSuccessState(cryptoList));
      } else {
        emit(CoinListFailedState(response.statusMessage!));
      }
    });

  }


}
