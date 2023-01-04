import '/core/enums/view_states.dart';
import '/core/services/crm/demandes_Activity_list_service.dart';
import '/core/services/local_storage_service.dart';
import '../../../../locator.dart';
import '../../base_view_model.dart';

class DemandesActivityListViewModel extends BaseViewModel {
  DemandesActivityListService _demandesListService =
      locator<DemandesActivityListService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> getActivitiesList(int startIndex, int fetchLimit) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getActivitiesList(startIndex, fetchLimit);
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> getActivitiesListProspect(String code) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getActivitiesListProspect(code);
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
