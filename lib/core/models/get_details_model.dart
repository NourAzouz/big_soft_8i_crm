class DetailsModel {
  dynamic code;
  dynamic title;
  DetailsModel({this.code, this.title});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    title = json['Title'];
  }
}

class DetailsResults {
  String? total;
  List<DetailsModel>? results;

  DetailsResults({this.total, this.results});

  DetailsResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DetailsModel>[];
      json['results'].forEach((v) {
        results?.add(DetailsModel.fromJson(v));
      });
    }
  }
}
