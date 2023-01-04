import '../view_models/base_view_model.dart';

import '../../locator.dart';
import '../services/local_storage_service.dart';

class StartupLogicViewModel extends BaseViewModel {
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<bool> isIntroViewAlreadySeen() async {
    bool _isAlreadySeen = await _localStorageService.isIntroViewAlreadySeen();
    return _isAlreadySeen;
  }

  Future<void> readConstantsFromLocalStorage() async {
    await _localStorageService.readConstantsFromSecureStorage();
  }
}
