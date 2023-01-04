class ExerciceModel {
  dynamic dateModified;
  dynamic libelleExc;
  dynamic etatExc;
  dynamic modifiedBy;
  dynamic owner;
  dynamic dateCreated;
  dynamic createdBy;
  dynamic codeExc;
  dynamic descExc;
  dynamic anneeExc;

  ExerciceModel({
    this.dateModified,
    this.libelleExc,
    this.etatExc,
    this.modifiedBy,
    this.owner,
    this.dateCreated,
    this.createdBy,
    this.codeExc,
    this.descExc,
    this.anneeExc,
  });

  ExerciceModel.fromJson(Map<dynamic, dynamic> json) {
    dateModified = json['DateModified'];
    libelleExc = json['LibelleExc'];
    etatExc = json['EtatExc'];
    modifiedBy = json['ModifiedBy'];
    owner = json['owner'];
    dateCreated = json['DateCreated'];
    createdBy = json['CreatedBy'];
    codeExc = json['CodeExc'];
    descExc = json['DescExc'];
    anneeExc = json['AnneeExc'];
  }
}

class ExerciceResults {
  dynamic? total;
  List<ExerciceModel>? results;

  ExerciceResults({this.total, this.results});

  ExerciceResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <ExerciceModel>[];
      json['results'].forEach((v) {
        results?.add(ExerciceModel.fromJson(v));
      });
    }
  }
}
