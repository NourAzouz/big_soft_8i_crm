class UniteModel {
  dynamic libelleUnit;
  dynamic codeUnit;

  UniteModel({this.libelleUnit, this.codeUnit});

  UniteModel.fromJson(Map<dynamic, dynamic> json) {
    libelleUnit = json['LibelleUnit'];
    codeUnit = json['CodeUnit'];
  }
}

class UniteResults {
  dynamic? total;
  List<UniteModel>? results;

  UniteResults({this.total, this.results});

  UniteResults.fromJson(Map<dynamic, dynamic> json) {
    List tempList = <UniteModel>[];
    total = json['total'];
    if (json['results'] != null) {
      json['results'].forEach((r) {
        var result = UniteModel.fromJson(r);
        if (result.libelleUnit.isNotEmpty) {
          tempList.add(result);
        }
      });
      results = <UniteModel>[];
      for (var result in tempList) {
        bool isPresent = false;
        for (var uniqueResult in results!) {
          if (uniqueResult.libelleUnit == result.libelleUnit) isPresent = true;
        }
        if (!isPresent) results?.add(result);
      }
    }
  }
}
