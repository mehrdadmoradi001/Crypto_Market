import 'package:flutter/material.dart';
import 'features/crypto_list/presentaion/coin_list/screens/coin_list_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoinListScreen(),
    );
  }
}