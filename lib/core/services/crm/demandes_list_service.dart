import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:big_soft_8i_crm/core/models/demandes_compte_model.dart';
import 'package:http/http.dart' as http;

import '../../../ui/views/crm/contact/demande_details_view.dart';
import '../../models/demandes_list_model.dart';
import '/core/constants/constants.dart';
import '/core/models/demandes_contact_list_model.dart';

class DemandesListService {
  Future<dynamic> getDemandes(int startIndex, int fetchLimit) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}/ContactCRMAction"),
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
    var demandesResponse = DemandesContactListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> updateProspectViewModel(
    SaveContactArgument saveContactArgument,
  ) async {
    var response;
    try {
      response = await http.post(
          Uri.parse("${Constants.baseURL}/ContactCRMAction"),
          headers: <String, String>{
            "Cookie": Constants.sessionId,
          },
          body: {
            "action": 'update',
            'CodeCtc': saveContactArgument.numCompte,
            'CodeCtc': saveContactArgument.numCompte,
            'Nom': saveContactArgument.nomText,
            'Prenom': saveContactArgument.prenomText,
            'Societe': '',
            'TelBureau': saveContactArgument.telBureauText,
            'TelMobile': saveContactArgument.telephoneText,
            'TelDomicile': '',
            'TelAutre': '',
            'Superieur': saveContactArgument.superieurText,
            'NomSuperieur': saveContactArgument.nomTiers,
            'CodeTiers': '',
            'NomTiers': '',
            'CodeProspect': '',
            'NomProspect': '',
            'SourceProspect': '',
            'Fonction': '',
            'LibFonction': '',
            'Service': '',
            'FaxBureau': '',
            'Email1': saveContactArgument.mailText,
            'Email2': '',
            'CodeCollab': '',
            'NomCollab': '',
            'PrenomCollab': '',
            'Ville': '',
            'Pays': '',
            'CodePostal': '',
            'Adresse': '',
            'BoitePostale': '',
            'AdresseAlt': '',
            'AutreBP': '',
            'ext-comp-1315': 'Contient',
            'ext-comp-1313': '',
            'filterValue': '',
            'Description': saveContactArgument.descriptionText,
            'ext-comp-1373': 'Contient',
            'ext-comp-1371': '',
            'filterValue': '',
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
      print("Fail");
      print(addContactbackMessage);
      return addContactbackMessage;
    }
  }

  Future<dynamic> deleteDemande(String code) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}/ContactCRMAction"),
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

  Future<dynamic> getCollab() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/crm/CollaborateurAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "",
          "limit": "",
          "action": "select",
          "code": "",
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var demandesResponse = DemandesCollabListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getFunction() async {
    var fonctionresponse;
    try {
      fonctionresponse = await http.post(
        Uri.parse("${Constants.baseURL}/FonctionAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "",
          "limit": "",
          "action": "select",
          "code": "",
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (fonctionresponse.contentLength == 0) {
      return 0;
    }
    var demandesResponse = FonctionListResults.fromJson(
      json.decode(fonctionresponse.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getsup() async {
    var supresponse;
    try {
      supresponse = await http.post(
        Uri.parse("${Constants.baseURL}/ContactCRMAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "",
          "limit": "",
          "action": "select",
          "code": "",
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (supresponse.contentLength == 0) {
      return 0;
    }
    var demandesResponse = SupListResults.fromJson(
      json.decode(supresponse.body),
    );
    return demandesResponse.results;
  }
}
