import '../view_models/base_view_model.dart';

import '../../locator.dart';
import '../services/local_storage_service.dart';

class IntroViewModel extends BaseViewModel {
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  setIntroViewAlreadySeenToTrue() async {
    await _localStorageService.setIntroViewAlreadySeenToTrue();
  }
}
