import '/core/enums/view_states.dart';
import '/core/services/crm/demandes_Prospect_list_service.dart';
import '/core/services/local_storage_service.dart';

import '../../../../locator.dart';
import '../../base_view_model.dart';

class DemandesProspectListViewModel extends BaseViewModel {
  DemandesProspectListService _demandesListService =
      locator<DemandesProspectListService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> getProspectsList(int startIndex, int fetchLimit) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getProspectsList(startIndex, fetchLimit);
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<bool> isFeatureDiscoveryAlreadySeen() async {
    bool _isFeatureDiscoveryAlreadySeen =
        await _localStorageService.isFeatureDiscoveryAlreadySeen();
    return _isFeatureDiscoveryAlreadySeen;
  }

  setFeatureDiscoveryAlreadySeenToTrue() async {
    await _localStorageService.setFeatureDiscoveryAlreadySeenToTrue();
  }
}
