import 'package:flutter/material.dart';
import '../../../../../constants/app_constants.dart';
import '../../../domain/entities/crypto.dart';

Widget CoinListItem(Crypto crypto) {
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