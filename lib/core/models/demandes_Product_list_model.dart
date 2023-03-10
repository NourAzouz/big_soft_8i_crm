class DemandesProductListResults {
  dynamic total;
  List<ProductsProductListModel>? results;

  DemandesProductListResults({this.total, this.results});

  DemandesProductListResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <ProductsProductListModel>[];
      json['results'].forEach((v) {
        results!.add(ProductsProductListModel.fromJson(v));
      });
    }
  }
}

class ProductsProductListModel {
  dynamic codeArticle;
  dynamic codeProduit;
  dynamic libelle;
  dynamic modele;
  dynamic reference;
  dynamic famille;
  dynamic stock;
  dynamic siteWeb;
  dynamic dateInitf;
  dynamic codeBarres;
  dynamic prix;
  dynamic codeMesure;
  dynamic tva;
  dynamic collab;
  dynamic refArt;

  ProductsProductListModel({
    this.codeArticle,
    this.codeProduit,
    this.libelle,
    this.modele,
    this.reference,
    this.famille,
    this.stock,
    this.siteWeb,
    this.codeBarres,
    this.dateInitf,
    this.prix,
    this.codeMesure,
    this.tva,
    this.collab,
    this.refArt,
  });

  ProductsProductListModel.fromJson(Map<dynamic, dynamic> json) {
    codeArticle = json['CodeArticle'];
    codeProduit = json['CodeProduit'];
    libelle = json["LibelleArticle"];
    modele = json['Modele'];
    reference = json['Reference'];
    famille = json['LibelleFamille'];
    stock = json['MAJStock'];
    siteWeb = json['SiteWeb'];
    dateInitf = json['DateInitf'].toString();
    codeBarres = json['CodeBarres'].toString();
    prix = json['PrixVente'].toString();
    codeMesure = json['CodeMesureVente'].toString();
    tva = json['CodeTva'].toString();
    collab = json['NomCollab'];
    refArt = json['ReferenceArticle'];
  }
}

class TVAListResults {
  dynamic total;
  List<TVAListModel>? results;

  TVAListResults({this.total, this.results});

  TVAListResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <TVAListModel>[];
      json['results'].forEach((v) {
        results!.add(TVAListModel.fromJson(v));
      });
    }
  }
}

class TVAListModel {
  dynamic codeTva;

  TVAListModel({
    this.codeTva,
  });
  TVAListModel.fromJson(Map<String, dynamic> json) {
    codeTva = json['CodeTva'].toString();
  }
}

class CatListResults {
  dynamic total;
  List<CatListModel>? results;

  CatListResults({this.total, this.results});

  CatListResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['results'] != null) {
      results = <CatListModel>[];
      json['results'].forEach((v) {
        results!.add(CatListModel.fromJson(v));
      });
    }
  }
}

class CatListModel {
  dynamic codeCat;

  CatListModel({
    this.codeCat,
  });
  CatListModel.fromJson(Map<String, dynamic> json) {
    codeCat = json['LibelleFamille'].toString();
  }
}
