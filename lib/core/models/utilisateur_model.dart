class UtilisateurModel {
  dynamic code_user;
  dynamic nom;
  dynamic prenom;
  dynamic log_user;
  //dynamic code_u_consom;
  //dynamic frais_finance;

  UtilisateurModel({
    this.code_user,
    this.nom,
    this.prenom,
    this.log_user,
    //this.code_u_consom,
    //this.frais_finance,
  });

  UtilisateurModel.fromJson(Map<String, dynamic> json) {
    code_user = json['CodeUser'];
    nom = json['Nom'];
    prenom = json['Prenom'];
    log_user = json['LogUser'];
    //code_u_consom = json['CodeUConsom'];
    //frais_finance = json['FraisFinance'];
  }
}

class UtilisateurResults {
  String? total;
  List<UtilisateurModel>? results;

  UtilisateurResults({this.total, this.results});

  UtilisateurResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <UtilisateurModel>[];
      json['results'].forEach((v) {
        results?.add(UtilisateurModel.fromJson(v));
      });
    }
  }
}
