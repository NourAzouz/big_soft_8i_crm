class DemandesCompteListResults {
  dynamic total;
  List<DemandesCompteListModel>? results;

  DemandesCompteListResults({this.total, this.results});

  DemandesCompteListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesCompteListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesCompteListModel.fromJson(v));
      });
    }
  }
}

class DemandesCompteListModel {
  dynamic codeTiers;
  dynamic nomTiers;
  dynamic tel;
  dynamic mail;
  dynamic assign;
  dynamic secteur;
  dynamic prop;
  dynamic effic;
  dynamic revenue;
  dynamic devis;
  dynamic description;
  DemandesCompteListModel({
    this.codeTiers,
    this.nomTiers,
    this.tel,
    this.mail,
    this.assign,
    this.secteur,
    this.prop,
    this.effic,
    this.revenue,
    this.devis,
    this.description,
  });

  DemandesCompteListModel.fromJson(Map<dynamic, dynamic> json) {
    codeTiers = json['NumTiers'].toString();
    nomTiers = json['NomTiers'].toString();
    tel = json['Telephone'].toString();
    mail = json['Email'].toString();
    assign = json['NomCollab'].toString();
    secteur = json['LibSecteur'].toString();
    prop = json['Proprietaire'].toString();
    effic = json['Effectif'].toString();
    revenue = json['RevenuAnnuel'].toString();
    devis = json['CodeDevise'].toString();
    description = json['Description'].toString();
  }
}
