class DemandesProspectListResults {
  dynamic total;
  List<DemandesProspectListModel>? results;

  DemandesProspectListResults({this.total, this.results});

  DemandesProspectListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesProspectListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesProspectListModel.fromJson(v));
      });
    }
  }
}

class DemandesProspectListModel {
  dynamic codeProspect;
  dynamic numProspect;
  dynamic nomProspect;
  dynamic prenomProspect;
  dynamic tel;
  dynamic titre;
  dynamic societe;
  dynamic origineProspect;
  dynamic libSecteurActivite;
  dynamic mail;
  dynamic chiffreAffaire;
  dynamic portable;
  dynamic nbremp;
  dynamic collab;
  dynamic dateCreated;
  dynamic dateModified;
  dynamic owner;
  dynamic note;
  dynamic status;
  dynamic description;

  DemandesProspectListModel({
    this.codeProspect,
    this.numProspect,
    this.nomProspect,
    this.prenomProspect,
    this.tel,
    this.titre,
    this.societe,
    this.origineProspect,
    this.libSecteurActivite,
    this.mail,
    this.chiffreAffaire,
    this.portable,
    this.nbremp,
    this.collab,
    this.dateCreated,
    this.dateModified,
    this.owner,
    this.note,
    this.status,
    this.description,
  });

  DemandesProspectListModel.fromJson(Map<dynamic, dynamic> json) {
    codeProspect = json['CodeProspect'];
    numProspect = json['NumProspect'];
    nomProspect = json['NomProspect'];
    prenomProspect = json['PrenomProspect'];
    titre = json['Titre'];
    societe = json['Societe'];
    origineProspect = json['LibOrigineProspect'];
    libSecteurActivite = json['LibSecteurActivite'];
    mail = json['Mail'];
    tel = json['Tel'].toString();
    chiffreAffaire = json['ChiffreAffaire'].toString();
    portable = json['Portable'].toString();
    nbremp = json['NbrEmp'].toString();
    collab = json['NomCollab'].toString() + ' ' + json['PrenomCollab'];
    dateCreated = json['DateCreated'];
    dateModified = json['DateModified'];
    owner = json['owner'].toString();
    note = json['Note'].toString();
    status = json['StatutProspect'].toString();
    description = json['Description'].toString();
  }
}

/////////////////////////////////////////////+

class DemandesOrgListResults {
  dynamic total;
  List<DemandesOrgListModel>? results;

  DemandesOrgListResults({this.total, this.results});

  DemandesOrgListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <DemandesOrgListModel>[];
      json['results'].forEach((v) {
        results!.add(DemandesOrgListModel.fromJson(v));
      });
    }
  }
}

class DemandesOrgListModel {
  dynamic orgp;

  DemandesOrgListModel({
    this.orgp,
  });
  DemandesOrgListModel.fromJson(Map<dynamic, dynamic> json) {
    orgp = json['Libelle'].toString();
  }
}

class SectListResults {
  dynamic total;
  List<SectListModel>? results;

  SectListResults({this.total, this.results});

  SectListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <SectListModel>[];
      json['results'].forEach((v) {
        results!.add(SectListModel.fromJson(v));
      });
    }
  }
}

class SectListModel {
  dynamic libelle;

  SectListModel({
    this.libelle,
  });
  SectListModel.fromJson(Map<dynamic, dynamic> json) {
    libelle = json['LibelleSecteur'].toString();
  }
}

class AssgListResults {
  dynamic total;
  List<AssgListModel>? results;

  AssgListResults({this.total, this.results});

  AssgListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <AssgListModel>[];
      json['results'].forEach((v) {
        results!.add(AssgListModel.fromJson(v));
      });
    }
  }
}

class AssgListModel {
  dynamic nompresup;
  //dynamic presup;

  AssgListModel({
    this.nompresup,
    //this.presup,
  });
  AssgListModel.fromJson(Map<dynamic, dynamic> json) {
    nompresup = json['Nom'].toString() + " " + json['Prenom'].toString();
    //presup = json['Prenom'].toString();
  }
}
