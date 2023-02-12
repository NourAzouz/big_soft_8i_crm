import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../ui/views/crm/activity/activity_details_view.dart';
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

  Future<dynamic> updateActivityViewModel(
    SaveActivityArgument saveActivityArgument,
  ) async {
    var response;
    try {
      response = await http.post(
          Uri.parse("${Constants.baseURL}/crm/ActiviteAction"),
          headers: <String, String>{
            "Cookie": Constants.sessionId,
          },
          body: {
            "action": "update",
            "gridLine": "{}",
            "Type": saveActivityArgument.type,
            "Numero": saveActivityArgument.num,
            "Sujet": saveActivityArgument.sujet,
            "DateDebut": saveActivityArgument.date,
            "HeureDebut": "",
            "Statut": saveActivityArgument.statut,
            "TypeActivite": saveActivityArgument.typeA,
            "Priorite": saveActivityArgument.priorite,
            "CodeCollab": "",
            "NomCollab": saveActivityArgument.assign,
            "PrenomCollab": "",
            "DateFin": "",
            "HeureFin": "",
            "Notification": "",
            "Lieu": saveActivityArgument.localisation,
            "TypeDoc": "PR",
            "NumDoc": "",
            "LibDoc": "",
            "CodeDoc": "",
            "CodeContact": "",
            "NomContact": "",
            "Description": saveActivityArgument.description,
          });
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }

    var isAddContactSuccess = json.decode(response.body)["success"];
    if (isAddContactSuccess) {
      print(isAddContactSuccess);
      return isAddContactSuccess;
    } else {
      var addContactbackMessage = json.decode(response.body)["feedback"];
      print(addContactbackMessage);
      return addContactbackMessage;
    }
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
