import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '/core/constants/constants.dart';
import '/core/models/documents_model.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;

class DocumentsService {
  Future<dynamic> getDocuments(String type, String code) async {
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/prh/PrhDemandeAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "sort": "",
          "dir": "ASC",
          "action": "selectAttachedFiles",
          "Type": type,
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
    var documentsResponse = DocumentsResults.fromJson(
      json.decode(response.body),
    );
    return documentsResponse.results;
  }

  Future<dynamic> uploadDocument(String filePath, String code) async {
    // await Future.delayed(Duration(seconds: 3));
    Map<String, String> headers = {
      "Cookie": Constants.sessionId,
    };
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "${Constants.baseURL}/${Constants.appName}/prh/PrhDemandeAction?action=UploadAttachedFiles&code=$code&CodeObj=PRHDMND",
        ),
      );
      request.headers.addAll(headers);
      request.files.add(
        http.MultipartFile(
          'file',
          File(filePath).readAsBytes().asStream(),
          File(filePath).lengthSync(),
          filename: filePath.split("/").last,
        ),
      );
      await request.send();
      // var res = await request.send();
      // var responseData = await res.stream.toBytes();
      // print(responseData);
      // var responseString = String.fromCharCodes(responseData);
      // print(responseString);
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
  }

  Future<dynamic> deleteDocument(String code) async {
    // await Future.delayed(Duration(seconds: 3));
    var response;
    try {
      response = await http.post(
        Uri.parse(
            "${Constants.baseURL}/${Constants.appName}/prh/PrhDemandeAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        body: {
          "action": "deleteAttachedFiles",
          "code": "|$code",
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
/*
  Future<dynamic> downloadDocument(
      String fileName,
      String objetId,
      String code,
      ) async {
    final externalDir = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    try {
      await FlutterDownloader.enqueue(
        url:
        "${Constants.baseURL}/apps/biggestion/viewer/downLoad.jsp?NFile=$fileName&TFile=document&ObjetId=$objetId&code=$code",
        savedDir: externalDir,
        fileName: fileName,
        headers: <String, String>{
          "Cookie": Constants.sessionId,
        },
        showNotification: true,
        openFileFromNotification: true,
      );
    } catch (err) {
      print(err);
    }
  }*/
}
