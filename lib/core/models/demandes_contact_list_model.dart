class DemandesContactListResults {
  dynamic total;
  List<DemandesContactListModel>? results;

  DemandesContactListResults({this.total, this.results});

  DemandesContactListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesContactListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesContactListModel.fromJson(v));
      });
    }
  }
}

class DemandesContactListModel {
  dynamic prenom;
  dynamic nom;
  dynamic compte;
  dynamic numcompte;
  dynamic telephone;
  dynamic fix;
  dynamic mail;
  dynamic assigne;
  dynamic codeTiers;
  dynamic nomTiers;
  dynamic telBureau;
  dynamic superieur;
  dynamic service;
  dynamic disc;

  dynamic fonction;

  dynamic codefunctions;
  DemandesContactListModel(
      {this.prenom,
      this.nom,
      this.compte,
      this.numcompte,
      this.telephone,
      this.fix,
      this.mail,
      this.assigne,
      this.codeTiers,
      this.nomTiers,
      this.telBureau,
      this.superieur,
      this.service,
      this.disc,
      this.codefunctions,
      this.fonction});

  DemandesContactListModel.fromJson(Map<dynamic, dynamic> json) {
    prenom = json['Prenom'];
    nom = json['Nom'];
    numcompte = json['CodeCtc'];
    compte = json['Contact'];
    telephone = json['TelMobile'];
    fix = json['TelDomicile'];
    mail = json['Email1'];
    assigne = json['NomCollab'];
    codeTiers = json['CodeTiers'];
    nomTiers = json['NomTiers'];
    telBureau = json['TelBureau'];
    superieur = json['NomSuperieur'];
    service = json['Service'];
    disc = json['Description'];
    fonction = json['LibFonction'];
    codefunctions = json['Fonction'];
  }
}

class ListContactResults {
  String? total;
  List<DemandesContactListModel>? results;

  ListContactResults({this.total, this.results});

  ListContactResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesContactListModel>[];
      json['results'].forEach((v) {
        results!.add(new DemandesContactListModel.fromJson(v));
      });
    }
  }
}
