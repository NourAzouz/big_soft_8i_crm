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
  dynamic code;
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
    this.code,
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
    code = json['CodeTiers'].toString();
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

class AssgCollabListResults {
  dynamic total;
  List<AssgCollabListModel>? results;

  AssgCollabListResults({this.total, this.results});

  AssgCollabListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <AssgCollabListModel>[];
      json['results'].forEach((v) {
        results!.add(AssgCollabListModel.fromJson(v));
      });
    }
  }
}

class AssgCollabListModel {
  dynamic npCollab;

  AssgCollabListModel({
    this.npCollab,
  });
  AssgCollabListModel.fromJson(Map<dynamic, dynamic> json) {
    npCollab = json['Nom'].toString() + " " + json['Prenom'].toString();
  }
}

class SecListResults {
  dynamic total;
  List<SecListModel>? results;

  SecListResults({this.total, this.results});

  SecListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <SecListModel>[];
      json['results'].forEach((v) {
        results!.add(SecListModel.fromJson(v));
      });
    }
  }
}

class SecListModel {
  dynamic libellesecteur;

  SecListModel({
    this.libellesecteur,
  });
  SecListModel.fromJson(Map<dynamic, dynamic> json) {
    libellesecteur = json['LibelleSecteur'].toString();
  }
}

class DevListResults {
  dynamic total;
  List<DevListModel>? results;

  DevListResults({this.total, this.results});

  DevListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DevListModel>[];
      json['results'].forEach((v) {
        results!.add(DevListModel.fromJson(v));
      });
    }
  }
}

class DevListModel {
  dynamic devise;

  DevListModel({
    this.devise,
  });
  DevListModel.fromJson(Map<dynamic, dynamic> json) {
    devise = json['LibelleDevise'].toString();
  }
}
