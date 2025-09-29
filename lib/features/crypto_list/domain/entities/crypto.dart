class Crypto {
  final String id;
  final String name;
  final String symbol;
  final double changePercent24hr;
  final double priceUsd;
  final double marketCapUsd;
  final int rank;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.changePercent24hr,
    required this.priceUsd,
    required this.marketCapUsd,
    required this.rank,
  });

  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      id: jsonMapObject['id'] ?? '',
      name: jsonMapObject['name'] ?? '',
      symbol: jsonMapObject['symbol'] ?? '',
      changePercent24hr: _parseDouble(jsonMapObject['changePercent24Hr']),
      priceUsd: _parseDouble(jsonMapObject['priceUsd']),
      marketCapUsd: _parseDouble(jsonMapObject['marketCapUsd']),
      rank: _parseInt(jsonMapObject['rank']),
    );
  }


  static double _parseDouble(dynamic value,  {double defaultDoubleValue = 0.0}) {
    if (value == null) return defaultDoubleValue;
    if (value is double) return defaultDoubleValue;
    if (value is int) return defaultDoubleValue;
    if (value is String) {
      return double.tryParse(value) ?? defaultDoubleValue;
    }
    return defaultDoubleValue;
  }

  static int _parseInt(dynamic value,  {int defaultIntValue = 0}) {
    if (value == null) return defaultIntValue;
    if (value is int) return defaultIntValue;
    if (value is double) return defaultIntValue;
    if (value is String) {
      return int.tryParse(value) ?? defaultIntValue;
    }
    return defaultIntValue;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Crypto &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}