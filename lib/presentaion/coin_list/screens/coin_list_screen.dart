import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../domain/entities/crypto.dart';
import '../bloc/coin_list_bloc.dart';
import '../widgets/coin_list_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key,}) : super(key: key);

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  bool isSearchLoadingVisible = false;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = CoinListBloc();
        bloc.add(LoadInitialCoinDataEvent());
        return bloc;
      },
      child: BlocConsumer<CoinListBloc, CoinListState>(
        listener: (context, state) {
          if (state is CoinListFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: blackColor,
            appBar: AppBar(
              backgroundColor: blackColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0,
              title: Text(
                'کریپتو بازار',
                style: TextStyle(
                    fontFamily: 'mr', fontSize: 35, color: Colors.white),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onChanged: (value) {
                          _filterList(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'رمز ارز خود را جستجو کنید',
                          hintStyle: TextStyle(
                              fontFamily: 'mr',
                              color: Colors.white,
                              fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: greenColor,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSearchLoadingVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'در حال آپدیت اطلاعات رمز ارزها...',
                        style: TextStyle(fontFamily: 'mr', color: greenColor),
                      ),
                    ),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                    backgroundColor: greyColor,
                    color: blackColor,
                    onRefresh: () async {
                      BlocProvider.of<CoinListBloc>(context)
                          .add(RefreshCoinDataEvent());
                    },
                    child: _buildByState(state),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildByState(CoinListState state) {
    return switch (state) {
      CoinListLoadingState() => Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 30.0,
          ),
        ),
      CoinListSuccessState() =>
        _buildSuccessListWidget(cryptoList: state.cryptoList),
      CoinListFailedState() => Center(
          child: Text(state.errorMessage),
        ),
    };
  }

  //get Data List
  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  //get input enter Key word and change data for list
  Future<void> _filterList(String enteredKeyWord) async {
    List<Crypto> cryptoResultList = [];

    if (enteredKeyWord.isEmpty) {
      setState(() {
        isSearchLoadingVisible = true;
      });
      var result = await _getData();
      // setState(() {
      //   cryptoList = result; //update list
      //   isSearchLoadingVisible = false;
      // });
      return;
    }

    // cryptoResultList = cryptoList!
    //     .where((element) => element.name
    //         .toLowerCase() //
    //         .contains(enteredKeyWord.toLowerCase()))
    //     .toList();

    setState(() {
     // cryptoList = cryptoResultList;
    });
  }
}

class _buildSuccessListWidget extends StatelessWidget {
  const _buildSuccessListWidget({
    super.key,
    required this.cryptoList,
  });

  final List<Crypto>? cryptoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList!.length,
      itemBuilder: (BuildContext context, index) =>
          CoinListItem(cryptoList![index]),
    );
  }
}
