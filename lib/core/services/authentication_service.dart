import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import '../constants/constants.dart';
import '../models/exercice_model.dart';
import '../models/unite_model.dart';

class AuthenticationService {
  Future<dynamic> getSessionIdFromHomePage() async {
    var response;
    try {
      // TODO: The new version of http.get function null safety sdk don't accept Strin but uri so we parse the uri from Strin to uri type
      response = await http
          .get(Uri.parse("${Constants.baseURL}/${Constants.appName}"))
          .timeout(const Duration(seconds: 15));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }

    try {
      var sessionId = response.headers["set-cookie"].split(";").first;
      return sessionId;
    } catch (_) {
      return "Une erreur est survenu lors du chargement des données. Contactez votre administrateur";
    }
  }

  Future<dynamic> login({
    required String domain,
    required String username,
    required String password,
  }) async {
    var response;
    try {
      print(Constants.baseURL);
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}AuthAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "select",
          "domaine": domain,
          "user": username,
          "mpasse": password,
          "lang": "fr",
          "isCheckedAD": "0",
          "isMobile": "1",
          "CodeUnit": "",
          "CodeExc": "",
          "AnneeExc": "",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return "Une erreur est survenu lors du chargement des données. Contactez votre administrateur";
    }
    var isAuthenticationSuccess = json.decode(response.body)["success"];
    if (isAuthenticationSuccess) {
      return isAuthenticationSuccess;
    } else {
      var authenticationFeedbackMessage =
          json.decode(response.body)["feedback"];
      return authenticationFeedbackMessage;
    }
  }

  Future<dynamic> getUnite() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}UniteAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "sort": "CodeUnit",
          "dir": "ASC",
          "action": "selectLine",
          "TypeObj": "Conn",
          "useCache": "true",
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
    var uniteResponse = UniteResults.fromJson(
      json.decode(response.body),
    );
    return uniteResponse.results;
  }

  Future<dynamic> getExercice() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}ExcAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "sort": "AnneeExc",
          "dir": "ASC",
          "action": "select",
          "useCache": "true",
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
    var exerciceResponse = ExerciceResults.fromJson(
      json.decode(response.body),
    );
    return exerciceResponse.results;
  }

  Future<dynamic> validateSessionAndFinishLoginProcess({
    required domaine,
    required username,
    required password,
    required codeUnite,
    required codeExercice,
    required anneeExercice,
  }) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}AuthAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "selectPack",
          "domaine": domaine,
          "user": username,
          "mpasse": password,
          "lang": "fr",
          "isCheckedAD": "0",
          "CodeUnit": codeUnite,
          "CodeExc": codeExercice,
          "AnneeExc": anneeExercice
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0 || response.contentLength == 17) {
      return 0;
    }
    var isValidateSessionSuccess = json.decode(response.body)["success"];
    if (isValidateSessionSuccess) {
      return isValidateSessionSuccess;
    }
  }

  Future<dynamic> logout() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}AuthAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "disconnect",
        },
      ).timeout(const Duration(seconds: 4));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return "Une erreur est survenu lors du chargement des données. Contactez votre administrateur";
    }
    var isLogoutSuccess = json.decode(response.body)["success"];
    return isLogoutSuccess;
  }
}
