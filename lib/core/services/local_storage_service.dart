import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class LocalStorageService {
  static const String INTRO_VIEW_ALREADY_SEEN = "introViewAlreadySeen";

  static const String DOMAINE = "domaine";
  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String IP_ADDRESS = "ipAddress";
  static const String LIBELLE_UNITE = "libelleUnite";
  static const String LIBELLE_EXERCICE = "libelleExercice";
  static const String IS_FEATURE_DISCOVERY_ALREADY_SEEN =
      "isFeatureDiscoveryAlreadySeen";

  static const String VALIDATE_SESSION_RESULT = "validateSessionResult";

  Future<bool> isIntroViewAlreadySeen() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool _isIntroViewAlreadySeen =
        _sharedPreferences.getBool(INTRO_VIEW_ALREADY_SEEN) ?? false;
    return _isIntroViewAlreadySeen;
  }

  setIntroViewAlreadySeenToTrue() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(INTRO_VIEW_ALREADY_SEEN, true);
  }

  Future<bool> isValidateSessionResult() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool _isValidateSessionResult =
        _sharedPreferences.getBool(VALIDATE_SESSION_RESULT) ?? false;
    return _isValidateSessionResult;
  }

  setValidateSessionResultToTrue() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(VALIDATE_SESSION_RESULT, true);
  }

  setValidateSessionResultToFalse() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(VALIDATE_SESSION_RESULT, false);
  }

  // Future<void> writeDomaineAndUsernameToSharedPreferences({
  //   String domaine,
  //   String username,
  // }) async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   await _sharedPreferences.setString(DOMAINE, domaine);
  //   await _sharedPreferences.setString(USERNAME, username);
  // }

  // Future<void> writePasswordToSharedPreferences({String password}) async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   await _sharedPreferences.setString(PASSWORD, password);
  // }

  // Future<void> removePasswordFromSharedPreferences() async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   await _sharedPreferences.remove(PASSWORD);
  // }

  // Future<void> writeLibelleUniteAndLibelleExerciceToSharedPreferences({
  //   String libelleUnite,
  //   String libelleExercice,
  // }) async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   await _sharedPreferences.setString(LIBELLE_UNITE, libelleUnite);
  //   await _sharedPreferences.setString(LIBELLE_EXERCICE, libelleExercice);
  // }

  // Future<void> readConstantsFromSharedPreferences() async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String domaine = _sharedPreferences.getString(DOMAINE);
  //   Constants.domaine = domaine;
  //   String username = _sharedPreferences.getString(USERNAME);
  //   Constants.username = username;
  //   String password = _sharedPreferences.getString(PASSWORD);
  //   Constants.password = password;
  //   String ipAddress = _sharedPreferences.getString(IP_ADDRESS);
  //   Constants.ipAddress = ipAddress;
  //   String libelleUnite = _sharedPreferences.getString(LIBELLE_UNITE);
  //   Constants.libelleUnite = libelleUnite;
  //   String libelleExercice = _sharedPreferences.getString(LIBELLE_EXERCICE);
  //   Constants.libelleExercice = libelleExercice;
  // }

  // writeIpAddressToSharedPreferences(String ipAdress) async {
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   await _sharedPreferences.setString(IP_ADDRESS, ipAdress);
  // }

  //TODO the same implementation as above but with secure storage
  Future<void> writeDomaineAndUsernameToSecureStorage({
    String? domaine,
    String? username,
  }) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: DOMAINE, value: domaine);
    await secureStorage.write(key: USERNAME, value: username);
  }

  Future<void> writePasswordToSecureStorage({String? password}) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: PASSWORD, value: password);
  }

  Future<void> removePasswordFromSecureStorage() async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: PASSWORD);
  }

  Future<void> writeLibelleUniteAndLibelleExerciceToSecureStorage({
    required String libelleUnite,
    required String libelleExercice,
  }) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: LIBELLE_UNITE, value: libelleUnite);
    await secureStorage.write(key: LIBELLE_EXERCICE, value: libelleExercice);
  }

  Future<void> readConstantsFromSecureStorage() async {
    final secureStorage = FlutterSecureStorage();
    String? domaine = await secureStorage.read(key: DOMAINE);
    Constants.domaine = domaine;
    String? username = await secureStorage.read(key: USERNAME);
    Constants.username = username;
    String? password = await secureStorage.read(key: PASSWORD);
    Constants.password = password;
    String? ipAddress = await secureStorage.read(key: IP_ADDRESS);
    Constants.ipAddress = ipAddress;
    String? libelleUnite = await secureStorage.read(key: LIBELLE_UNITE);
    Constants.libelleUnite = libelleUnite;
    String? libelleExercice = await secureStorage.read(key: LIBELLE_EXERCICE);
    Constants.libelleExercice = libelleExercice;
  }

  writeIpAddressToSecureStorage(String ipAdress) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: IP_ADDRESS, value: ipAdress);
  }

  Future<bool> isFeatureDiscoveryAlreadySeen() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool _isFeatureDiscoveryAlreadySeen =
        _sharedPreferences.getBool(IS_FEATURE_DISCOVERY_ALREADY_SEEN) ?? false;
    return _isFeatureDiscoveryAlreadySeen;
  }

  setFeatureDiscoveryAlreadySeenToTrue() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(IS_FEATURE_DISCOVERY_ALREADY_SEEN, true);
  }
}
