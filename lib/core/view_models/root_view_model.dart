import '../view_models/base_view_model.dart';

import '../../locator.dart';
import '../services/authentication_service.dart';
import '../services/local_storage_service.dart';

class RootViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> logout() async {
    var logoutResult = await _authenticationService.logout();
    await _localStorageService.setValidateSessionResultToFalse();
    print(_localStorageService.isValidateSessionResult());
    return logoutResult;
  }
}
