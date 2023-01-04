import '../view_models/base_view_model.dart';

import '../../locator.dart';
import '../enums/view_states.dart';
import '../services/local_storage_service.dart';

class HomeViewModel extends BaseViewModel {
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<bool> isFeatureDiscoveryAlreadySeen() async {
    bool _isFeatureDiscoveryAlreadySeen =
        await _localStorageService.isFeatureDiscoveryAlreadySeen();
    return _isFeatureDiscoveryAlreadySeen;
  }

  setFeatureDiscoveryAlreadySeenToTrue() async {
    await _localStorageService.setFeatureDiscoveryAlreadySeenToTrue();
  }
}
