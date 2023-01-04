class WilayaModel {
  String? codeTiers;
  String? nomTiers;

  WilayaModel({
    this.codeTiers,
    this.nomTiers,
  });

  WilayaModel.fromJson(Map<String, dynamic> json) {
    codeTiers = json['CodeTiers'];
    nomTiers = json['NomTiers'];
  }
}

class WilayaResults {
  String? total;
  List<WilayaModel>? results;

  WilayaResults({this.total, this.results});

  WilayaResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <WilayaModel>[];
      json['results'].forEach((v) {
        results!.add(new WilayaModel.fromJson(v));
      });
    }
  }
}
