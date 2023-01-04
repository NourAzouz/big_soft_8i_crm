import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '/core/constants/constants.dart';
import '/core/models/demandes_Affaire_list_model.dart';
import 'package:http/http.dart' as http;

class DemandesAffaireListService {
  Future<dynamic> getDemandes(int startIndex, int fetchLimit) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/AffaireAction"),
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
    var demandesResponse = DemandesAffaireListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getAffaireDetails(String code_doc) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/AffaireAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "select",
          "code": code_doc,
        },
      ).timeout(const Duration(seconds: 15));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var affaireDetailsResponse = DemandesAffaireListResults.fromJson(
      json.decode(response.body),
    );
    return affaireDetailsResponse.results?.first;
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
