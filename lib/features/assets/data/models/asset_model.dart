class AssetModel {
  List<AssetModelData>? assetData;
  int? timestamp;

  AssetModel({this.assetData, this.timestamp});

  AssetModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      assetData = <AssetModelData>[];
      json['data'].forEach((v) {
        assetData!.add(AssetModelData.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assetData != null) {
      data['data'] = assetData!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class AssetModelData {
  String? id;
  int? rank;
  String? symbol;
  String? name;
  double? supply;
  double? maxSupply;
  double? marketCapUsd;
  double? volumeUsd24Hr;
  double? priceUsd;
  double? changePercent24Hr;
  double? vwap24Hr;
  String? explorer;

  AssetModelData(
      {this.id,
      this.rank,
      this.symbol,
      this.name,
      this.supply,
      this.maxSupply,
      this.marketCapUsd,
      this.volumeUsd24Hr,
      this.priceUsd,
      this.changePercent24Hr,
      this.vwap24Hr,
      this.explorer});

  AssetModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = int.parse(json['rank']);
    symbol = json['symbol'];
    name = json['name'];
    supply = double.parse(json['supply'] ?? '0');
    maxSupply = double.parse(json['maxSupply'] ?? '0');
    marketCapUsd = double.parse(json['marketCapUsd'] ?? '0');
    volumeUsd24Hr = double.parse(json['volumeUsd24Hr'] ?? '0');
    priceUsd = double.parse(json['priceUsd'] ?? '0');
    changePercent24Hr = double.parse(json['changePercent24Hr'] ?? '0');
    vwap24Hr = double.parse(json['vwap24Hr'] ?? '0');
    explorer = json['explorer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rank'] = rank;
    data['symbol'] = symbol;
    data['name'] = name;
    data['supply'] = supply;
    data['maxSupply'] = maxSupply;
    data['marketCapUsd'] = marketCapUsd;
    data['volumeUsd24Hr'] = volumeUsd24Hr;
    data['priceUsd'] = priceUsd;
    data['changePercent24Hr'] = changePercent24Hr;
    data['vwap24Hr'] = vwap24Hr;
    data['explorer'] = explorer;
    return data;
  }
}
