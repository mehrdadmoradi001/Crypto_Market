class Crypto {
  String id;
  String name;
  String symbol;
  double changePercent24hr;
  double priceUsd;
  double marketCapUsd;
  int rank;

  Crypto(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24hr,
    this.priceUsd,
    this.marketCapUsd,
    this.rank,
  );

  factory Crypto.fromMapJson(Map<String,dynamic> jsonMapObject){
    return Crypto(
      jsonMapObject['id'],
      jsonMapObject['name'],
      jsonMapObject['symbol'],
      jsonMapObject['changePercent24Hr'],
      jsonMapObject['priceUsd'],
      jsonMapObject['marketCapUsd'],
      jsonMapObject['rank'],
    );
  }

}
