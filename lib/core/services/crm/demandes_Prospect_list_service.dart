import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../../ui/views/crm/prospect/demande_Prospect_details_view.dart';
import '/core/constants/constants.dart';
import '/core/models/demandes_Prospect_list_model.dart';
import 'package:http/http.dart' as http;

class DemandesProspectListService {
  Future<dynamic> getProspectsList(int startIndex, int fetchLimit) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}/ProspectAction"),
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
    var demandesResponse = DemandesProspectListResults.fromJson(
      json.decode(response.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> updateProspectViewModel(
    SaveProspectArgument saveContactArgument,
  ) async {
    var response;
    try {
      await http.post(Uri.parse("${Constants.baseURL}/ProspectAction"),
          headers: <String, String>{
            "Cookie": Constants.sessionId,
          },
          body: {
            "action": "update",
            "gridLine": "",
            "gridDocuments": "{}",
            "CodeProspect": "PR1SYS2022",
            "NumProspect": saveContactArgument.numProspect,
            'NomProspect': saveContactArgument.nomProspect,
            'PrenomProspect': saveContactArgument.prenomProspect,
            'Titre': saveContactArgument.titre,
            'Objet': '',
            'Societe': "ESPI",
            "OrigineProspect": "31a68806d94e4b5490da4a6bc5cae4f0",
            "LibSecteurActivite": "Industrie",
            "SecteurActivite": "In",
            "Note": "10415ba238ea4c6fa093a663f81874fb",
            "StatutProspect": "7e48faa453dd47bb9a09363de25fb31d",
            "DateContact": "2022-06-16",
            "CodeCollab": "habes",
            "NomCollab": "Habes",
            "PrenomCollab": "Djalil",
            "Tel": saveContactArgument.telText,
            "Telecopie": '',
            "Portable": "0557406080",
            "Mail": saveContactArgument.mail,
            "Mail2": "",
            "SiteWeb": '',
            "Skype": '',
            "FB": '',
            "NbrEmp": '0',
            "ChiffreAffaire": ' 0,00',
            "Rue": '',
            "CodePostal": '',
            "Ville": '',
            "Region": '',
            "Pays": '',
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

  Future<dynamic> getProspectDetails(String code_doc) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("${Constants.baseURL}/${Constants.appName}/ProspectAction"),
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
    var prospectDetailsResponse = DemandesProspectListResults.fromJson(
      json.decode(response.body),
    );
    return prospectDetailsResponse.results?.first;
  }

  //////////////////////////////////////////////
  Future<dynamic> getorg() async {
    var orgresponse;
    try {
      orgresponse = await http.post(
        Uri.parse("${Constants.baseURL}/OrigineProspectAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "0",
          "limit": "25",
          "sort": "",
          "dir": "ASC",
          "action": "select",
          "code": "",
          "CGrp": ""
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (orgresponse.contentLength == 0) {
      return 0;
    }
    var demandesResponse = DemandesOrgListResults.fromJson(
      json.decode(orgresponse.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getsect() async {
    var sectresponse;
    try {
      sectresponse = await http.post(
        Uri.parse("${Constants.baseURL}/base/SecteurAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "0",
          "limit": "25",
          "sort": "",
          "dir": "ASC",
          "action": "select",
          "code": "",
          "CGrp": ""
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (sectresponse.contentLength == 0) {
      return 0;
    }
    var demandesResponse = SectListResults.fromJson(
      json.decode(sectresponse.body),
    );
    return demandesResponse.results;
  }

  Future<dynamic> getassg() async {
    var assgresponse;
    try {
      assgresponse = await http.post(
        Uri.parse("${Constants.baseURL}/crm/CollaborateurAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "start": "0",
          "limit": "25",
          "sort": "",
          "dir": "ASC",
          "action": "select",
          "code": "",
          "CGrp": ""
        },
      ).timeout(const Duration(seconds: 50));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (assgresponse.contentLength == 0) {
      return 0;
    }
    var demandesResponse = AssgListResults.fromJson(
      json.decode(assgresponse.body),
    );
    return demandesResponse.results;
  }
}
