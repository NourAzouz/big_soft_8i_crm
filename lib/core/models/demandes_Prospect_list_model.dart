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
