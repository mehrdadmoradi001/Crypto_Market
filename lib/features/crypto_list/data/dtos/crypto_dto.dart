class CryptoDTO {
  final String? id;
  final String? name;
  final String? symbol;
  final String? changePercent24Hr;
  final String? priceUsd;
  final String? marketCapUsd;
  final String? rank;

  CryptoDTO({
    this.id,
    this.name,
    this.symbol,
    this.changePercent24Hr,
    this.priceUsd,
    this.marketCapUsd,
    this.rank,
  });

  // منطق پارس کردن JSON به اینجا منتقل می‌شود
  factory CryptoDTO.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return CryptoDTO(
      id: jsonMapObject['id'],
      name: jsonMapObject['name'],
      symbol: jsonMapObject['symbol'],
      changePercent24Hr: jsonMapObject['changePercent24Hr'],
      priceUsd: jsonMapObject['priceUsd'],
      marketCapUsd: jsonMapObject['marketCapUsd'],
      rank: jsonMapObject['rank'],
    );
  }
}