import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:big_soft_8i_crm/ui/views/crm/product/demande_Product_details_view.dart';
import 'package:http/http.dart' as http;

import '/core/constants/constants.dart';
import '/core/models/demandes_Product_list_model.dart';

class DemandesProductListService {
  Future<dynamic> getProductsList(int startIndex, int fetchLimit) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/ProduitAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": startIndex.toString(),
          "limit": fetchLimit.toString(),
          "sort": "",
          "dir": "ASC",
          "action": "select",
          "code": "",
          "CGrp": "",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var demandesResponse = DemandesProductListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> updateProspectViewModel(
    SaveProductArgument saveContactArgument,
  ) async {
    var response;
    try {
      await http.post(
          Uri.parse(
              "${Constants.baseURL}/${Constants.appName}/crm/ProduitAction"),
          headers: <String, String>{
            "Cookie": Constants.sessionId,
          },
          body: {
            "action": "update",
            "CodeArticle": saveContactArgument.codeArticle,
            "LibelleArticle": saveContactArgument.libelleText,
            "Modele": saveContactArgument.modeleText,
            "DebutSupport": "",
            "FinSupport": "",
            "Reference": saveContactArgument.referenceText,
            "SiteWeb": "",
            "DateInit": "",
            "MAJStock": saveContactArgument.stockText,
            "CodeFamille": "AV",
            "LibelleFamille": saveContactArgument.familleText,
            "FinVente": "",
            "CodeFourPrincipal": "",
            "ReferenceArticle": "",
            "CodeBarres": "",
            "Actif": "1",
            "PrixVente": saveContactArgument.prixText,
            "CodeMesureVente": "U",
            "CodeTva": "19",
            "NiveauReap": "0",
            "CodeCollab": "",
            "NomCollab": "",
            "PrenomCollab": "",
            "DescArticle": "",
          });
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    //  if (response.contentLength == 0) {
    //  return 0;
    //}
    /*
    print(response);
    var isAddContactSuccess = json.decode(response.body)["success"];
    if (isAddContactSuccess) {
      return isAddContactSuccess;
    } else {
      var addContactbackMessage = json.decode(response.body)["feedback"];
      return addContactbackMessage;
    }*/
  }

  Future<dynamic> getProductsProspectList(String code) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}/ProspectAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "0",
          "limit": "25",
          "sort": "",
          "dir": "ASC",
          "action": "selectLine",
          "code": code,
          "CGrp": "",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var demandesResponse = DemandesProductListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> deleteDemande(String code) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/ProduitAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "delete",
          "code": code,
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var isDeleteSuccess = json.decode(response.body)["success"];
    if (isDeleteSuccess) {
      return isDeleteSuccess;
    } else {
      var deleteFeedbackMessage = json.decode(response.body)["feedback"];
      return deleteFeedbackMessage;
    }
  }
}
