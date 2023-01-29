class DemandesActivityListResults {
  dynamic total;
  List<DemandesActivityListModel>? results;

  DemandesActivityListResults({this.total, this.results});

  DemandesActivityListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesActivityListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesActivityListModel.fromJson(v));
      });
    }
  }
}

class DemandesActivityListModel {
  dynamic numero;
  dynamic sujet;
  dynamic dateDebut;
  dynamic heureDebut;
  dynamic lieu;
  dynamic statut;
  dynamic typedoc;
  dynamic codeDoc;
  dynamic heurefin;
  dynamic description;
  dynamic dateCreated;
  dynamic dateModified;
  dynamic nomContact;
  dynamic owner;
  dynamic priorite;
  dynamic type;
  dynamic typeA;

  DemandesActivityListModel({
    this.numero,
    this.sujet,
    this.dateDebut,
    this.heureDebut,
    this.lieu,
    this.statut,
    this.typedoc,
    this.codeDoc,
    this.heurefin,
    this.description,
    this.nomContact,
    this.dateCreated,
    this.dateModified,
    this.owner,
    this.priorite,
    this.type,
    this.typeA,
  });

  DemandesActivityListModel.fromJson(Map<dynamic, dynamic> json) {
    numero = json['Numero'].toString();
    sujet = json['Sujet'].toString();
    var d = json['DateDebut'].toString();
    dateDebut = d[0] + d[1] + d[2] + d[3] + d[4] + d[5] + d[6] + d[7] + d[8];
    heureDebut = json['HeureDebut:'].toString();
    heurefin = json['HeureFin:'].toString();
    description = json['Description'].toString();
    statut = json['Statut'].toString();
    lieu = json['Lieu'].toString();
    typedoc = json['TypeDoc'].toString();
    codeDoc = json['CodeDoc'].toString();
    nomContact = json['NomCollab'].toString();
    dateCreated = json['DateCreated'];
    dateModified = json['DateModified'];
    owner = json['owner'].toString();
    priorite = json['Priorite'].toString();
    type = json['Type'].toString();
    typeA = json['TypeActivite'].toString();
  }
}
