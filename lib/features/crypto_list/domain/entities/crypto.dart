import 'package:equatable/equatable.dart';

class Crypto extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double changePercent24hr;
  final double priceUsd;
  final double marketCapUsd;
  final int rank;

  const Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.changePercent24hr,
    required this.priceUsd,
    required this.marketCapUsd,
    required this.rank,
  });


// به جای پیاده‌سازی دستی، فقط لیست پراپرتی‌های مورد نظر برای مقایسه را مشخص کنید
  @override
  List<Object?> get props => [
    id,
    name,
    symbol,
    changePercent24hr,
    priceUsd,
    marketCapUsd,
    rank,
  ];

  @override
  bool get stringify => true;

/*  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Crypto &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;*/

}
