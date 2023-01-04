class DemandesAffaireListResults {
  dynamic total;
  List<DemandesAffaireListModel>? results;

  DemandesAffaireListResults({this.total, this.results});

  DemandesAffaireListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesAffaireListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesAffaireListModel.fromJson(v));
      });
    }
  }
}

class DemandesAffaireListModel {
  dynamic numero;
  dynamic nom;
  dynamic montant;
  dynamic suivant;
  dynamic date;
  dynamic codeEtape;
  dynamic codeContact;
  dynamic codeTiers;
  dynamic nomTiers;
  dynamic typePros;
  dynamic desc;
  dynamic prob;
  dynamic dateCreated;
  dynamic dateCr;
  dynamic dateModified;
  dynamic owner;

  DemandesAffaireListModel({
    this.numero,
    this.nom,
    this.date,
    this.montant,
    this.suivant,
    this.codeEtape,
    this.codeContact,
    this.codeTiers,
    this.nomTiers,
    this.typePros,
    this.desc,
    this.prob,
    this.dateCreated,
    this.dateCr,
    this.dateModified,
    this.owner,
  });

  DemandesAffaireListModel.fromJson(Map<dynamic, dynamic> json) {
    numero = json['Numero'];
    nom = json['Nom'];
    date = json['DateEcheance'].toString();
    typePros = json['TypePros'];
    montant = json['Montant'].toString();
    desc = json['Description'];
    nomTiers = json['NomTiers'];
    suivant = json['Suivant'];
    prob = json['Probabilite'].toString();
    dateCreated = json['DateCreated'];
    dateCr = json['DateCreated'];
    dateModified = json['DateModified'];
    owner = json['owner'].toString();
  }
}
