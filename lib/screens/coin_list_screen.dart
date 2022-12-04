import 'package:crypto_market/data/constants/constants.dart';
import 'package:crypto_market/data/model/crypto.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: Text(
          'کریپتو بازار',
          style: TextStyle(fontFamily: 'mr'),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (BuildContext context, index) => ListTile(
            title: Text(
              cryptoList![index].name,
              style: TextStyle(color: greenColor),
            ),
            subtitle: Text(
              cryptoList![index].symbol,
              style: TextStyle(color: greyColor),
            ),
            leading: SizedBox(
              width: 30.0,
              child: Center(
                child: Text(
                  cryptoList![index].rank.toString(),
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
                        cryptoList![index].priceUsd.toStringAsFixed(2),
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 16
                        ),
                      ),
                      Text(
                        cryptoList![index].changePercent24hr.toStringAsFixed(2),
                        style: TextStyle(
                          color: _getColorChangeText(
                              cryptoList![index].changePercent24hr),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 50.0,
                      child: _getIconChangePercent(
                          cryptoList![index].changePercent24hr)),
                ],
              ),
            ),
          ),
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
}
