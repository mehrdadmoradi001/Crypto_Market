import 'package:flutter/material.dart';

import 'features/crypto_list/presentaion/coin_list/screens/coin_list_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CoinListScreen(),
    );
  }
}

