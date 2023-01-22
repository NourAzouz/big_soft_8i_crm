class DemandesListResults {
  dynamic total;
  List<DemandesListModel>? results;

  DemandesListResults({this.total, this.results});

  DemandesListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesListModel.fromJson(v));
      });
    }
  }
}

class DemandesListModel {
  dynamic prenom;
  dynamic nom;
  dynamic compte;
  dynamic numcompte;
  dynamic telephone;
  dynamic fix;
  dynamic mail;
  dynamic codeTiers;
  dynamic nomTiers;
  dynamic telBureau;
  dynamic superieur;
  dynamic service;
  dynamic disc;
  dynamic codesup;

  dynamic functions;

  dynamic codefunctions;
  DemandesListModel(
      {this.prenom,
      this.nom,
      this.compte,
      this.numcompte,
      this.telephone,
      this.fix,
      this.mail,
      this.codeTiers,
      this.nomTiers,
      this.telBureau,
      this.codesup,
      this.superieur,
      this.service,
      this.codefunctions,
      this.functions,
      this.disc});

  DemandesListModel.fromJson(Map<dynamic, dynamic> json) {
    prenom = json['Prenom'];
    nom = json['Nom'];
    numcompte = json['CodeCtc'];
    compte = json['Contact'];
    telephone = json['TelMobile'];
    fix = json['TelDomicile'];
    mail = json['Email1'];
    codeTiers = json['CodeTiers'];
    nomTiers = json['NomTiers'];
    telBureau = json['TelBureau'];
    superieur = json['NomSuperieur'];
    service = json['Service'];
    disc = json['Description'];
  }
}

class ListResults {
  String? total;
  List<DemandesListModel>? results;

  ListResults({this.total, this.results});

  ListResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    if (json['results'] != null) {
      results = <DemandesListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesListModel.fromJson(v));
      });
    }
  }
}

class DemandesCollabListResults {
  dynamic total;
  List<DemandesCollabListModel>? results;

  DemandesCollabListResults({this.total, this.results});

  DemandesCollabListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesCollabListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesCollabListModel.fromJson(v));
      });
    }
  }
}

class DemandesCollabListModel {
  dynamic codeCollab;

  DemandesCollabListModel({
    this.codeCollab,
  });
  DemandesCollabListModel.fromJson(Map<dynamic, dynamic> json) {
    codeCollab = json['CodeCollab'].toString();
  }
}

class FonctionListResults {
  dynamic total;
  List<FonctionListModel>? results;

  FonctionListResults({this.total, this.results});

  FonctionListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <FonctionListModel>[];
      json['results'].forEach((v) {
        results!.add(FonctionListModel.fromJson(v));
      });
    }
  }
}

class FonctionListModel {
  dynamic codefonction;
  dynamic libellefonction;

  FonctionListModel({
    this.codefonction,
    this.libellefonction,
  });
  FonctionListModel.fromJson(Map<dynamic, dynamic> json) {
    codefonction = json['Code'].toString();
    libellefonction = json['Libelle'].toString();
  }
}

class SupListResults {
  dynamic total;
  List<SupListModel>? results;

  SupListResults({this.total, this.results});

  SupListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <SupListModel>[];
      json['results'].forEach((v) {
        results!.add(SupListModel.fromJson(v));
      });
    }
  }
}

class SupListModel {
  dynamic nompresup;
  //dynamic presup;

  SupListModel({
    this.nompresup,
    //this.presup,
  });
  SupListModel.fromJson(Map<dynamic, dynamic> json) {
    nompresup = json['Nom'].toString() + " " + json['Prenom'].toString();
    //presup = json['Prenom'].toString();
  }
}
