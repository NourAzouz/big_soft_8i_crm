import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '/core/constants/constants.dart';
import '/core/models/demandes_Prospect_ACT_list_model.dart';

class DemandesActivityListService {
  Future<dynamic> getActivitiesList(int startIndex, int fetchLimit) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/ActiviteAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": startIndex.toString(),
          "limit": fetchLimit.toString(),
          "sort": "DateDebut",
          "dir": "DESC",
          'type': 'CAL',
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
    var demandesResponse = DemandesActivityListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getActivitiesListProspect(String code) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/ActiviteAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "0",
          "limit": "25",
          "dir": "ASC",
          'type': 'PR',
          "action": "select",
          "code": "",
          "CodeDoc": code,
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
    var demandesResponse = DemandesActivityListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getActivityDetails(String code_doc) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/crm/ActiviteAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "select",
          "code": code_doc,
          "type": "CAL",
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
    var activityDetailsResponse = DemandesActivityListResults.fromJson(
      json.decode(response.body),
    );
    return activityDetailsResponse.results?.first;
  }
}
