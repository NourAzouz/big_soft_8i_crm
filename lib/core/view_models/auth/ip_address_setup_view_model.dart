import '../base_view_model.dart';

import '../../../locator.dart';
import '../../enums/view_states.dart';
import '../../services/authentication_service.dart';
import '../../services/local_storage_service.dart';

class IpAddressSetupViewModel extends BaseViewModel {
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<dynamic> getSessionIdFromHomePage() async {
    changeState(ViewState.Busy);
    var sessionResult = await _authenticationService.getSessionIdFromHomePage();
    changeState(ViewState.Idle);
    return sessionResult;
  }

  writeIpAddressToLocalStorage(String ipAddress) {
    _localStorageService.writeIpAddressToSecureStorage(ipAddress);
  }
}
