class DocumentsResults {
  dynamic total;
  List<DocumentsModel>? results;

  DocumentsResults({this.total, this.results});

  DocumentsResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DocumentsModel>[];
      json['results'].forEach((v) {
        results!.add(new DocumentsModel.fromJson(v));
      });
    }
  }
}

class DocumentsModel {
  dynamic codeUConsom;
  dynamic codeLine;
  dynamic nameFile;
  dynamic dateModified;
  dynamic modifiedBy;
  dynamic owner;
  dynamic dateCreated;
  dynamic createdBy;
  dynamic note;
  dynamic codeUnit;
  dynamic code;
  dynamic objetId;

  DocumentsModel({
    this.codeUConsom,
    this.codeLine,
    this.nameFile,
    this.dateModified,
    this.modifiedBy,
    this.owner,
    this.dateCreated,
    this.createdBy,
    this.note,
    this.codeUnit,
    this.code,
    this.objetId,
  });

  DocumentsModel.fromJson(Map<dynamic, dynamic> json) {
    codeUConsom = json['CodeUConsom'];
    codeLine = json['CodeLine'];
    nameFile = json['NameFile'];
    dateModified = json['DateModified'];
    modifiedBy = json['ModifiedBy'];
    owner = json['owner'];
    dateCreated = json['DateCreated'];
    createdBy = json['CreatedBy'];
    note = json['Note'];
    codeUnit = json['CodeUnit'];
    code = json['Code'];
    objetId = json['ObjetId'];
  }
}
