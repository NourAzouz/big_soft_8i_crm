import '../../../locator.dart';
import '../../enums/view_states.dart';
import '../../services/authentication_service.dart';
import '../../services/local_storage_service.dart';
import '../base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Future<dynamic> login({
    required String domain,
    required String username,
    required String password,
  }) async {
    changeState(ViewState.Busy);
    var loginResult = await _authenticationService.login(
      domain: domain,
      username: username,
      password: password,
    );
    changeState(ViewState.Idle);
    return loginResult;
  }

  Future<void> writeDomaineAndUsernameToLocalStorage({
    String? domaine,
    String? username,
  }) async {
    changeState(ViewState.Busy);
    await _localStorageService.writeDomaineAndUsernameToSecureStorage(
      domaine: domaine,
      username: username,
    );
    changeState(ViewState.Idle);
  }

  Future<void> writePasswordToLocalStorage({
    String? password,
  }) async {
    changeState(ViewState.Busy);
    await _localStorageService.writePasswordToSecureStorage(password: password);
    changeState(ViewState.Idle);
  }

  Future<void> removePasswordFromLocalStorage() async {
    changeState(ViewState.Busy);
    await _localStorageService.removePasswordFromSecureStorage();
    changeState(ViewState.Idle);
  }

  Future<dynamic> logout() async {
    var logoutResult = await _authenticationService.logout();
    await _localStorageService.setValidateSessionResultToFalse();
    print(_localStorageService.isValidateSessionResult());
    return logoutResult;
  }
}
