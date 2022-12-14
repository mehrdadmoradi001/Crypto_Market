import 'package:crypto_market/data/constants/constants.dart';
import 'package:crypto_market/data/model/crypto.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  bool isSearchLoadingVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //after refresh - update and fill list
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'کریپتو بازار',
          style: TextStyle(fontFamily: 'mr'),
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
                        fontFamily: 'mr', color: Colors.white, fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
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
                  List<Crypto> freshData = await _getData();
                  setState(
                    () {
                      cryptoList = freshData;
                    },
                  );
                },
                child: ListView.builder(
                  itemCount: cryptoList!.length,
                  itemBuilder: (BuildContext context, index) =>
                      _getListTile(cryptoList![index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getListTile(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: greenColor),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: greyColor),
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: greyColor),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(color: greyColor, fontSize: 16),
                ),
                Text(
                  crypto.changePercent24hr.toStringAsFixed(2),
                  style: TextStyle(
                    color: _getColorChangeText(crypto.changePercent24hr),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 50.0,
                child: _getIconChangePercent(crypto.changePercent24hr)),
          ],
        ),
      ),
    );
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }

  Color _getColorChangeText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
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
      setState(() {
        cryptoList = result; //update list
        isSearchLoadingVisible = false;
      });
      return;
    }

    cryptoResultList = cryptoList!
        .where((element) => element.name
            .toLowerCase() //
            .contains(enteredKeyWord.toLowerCase()))
        .toList();

    setState(() {
      cryptoList = cryptoResultList;
    });
  }

}
