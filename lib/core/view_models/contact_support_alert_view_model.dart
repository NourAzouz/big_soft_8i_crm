import '../../locator.dart';
import '../enums/view_states.dart';
import '../services/authentication_service.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

class ContactSupportAlertViewModel extends BaseViewModel {
  // TODO: Return auth function
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> logout() async {
    changeState(ViewState.Busy);
    var logoutResult = await _authenticationService.logout();
    await _localStorageService.setValidateSessionResultToFalse();
    //print(_localStorageService.isValidateSessionResult());
    changeState(ViewState.Idle);
    return logoutResult;
  }
}
