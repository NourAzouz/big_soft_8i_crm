import '/core/enums/view_states.dart';
import '/core/services/crm/demandes_Affaire_list_service.dart';
import '/core/services/local_storage_service.dart';

import '../../../../locator.dart';
import '../../base_view_model.dart';

class DemandesAffaireListViewModel extends BaseViewModel {
  DemandesAffaireListService _demandesListService =
      locator<DemandesAffaireListService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> getDemandes(int startIndex, int fetchLimit) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getDemandes(startIndex, fetchLimit);
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> deleteDemande(String code) async {
    changeState(ViewState.Busy);
    var deleteDemandeResult = await _demandesListService.deleteDemande(code);
    changeState(ViewState.Idle);
    return deleteDemandeResult;
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
