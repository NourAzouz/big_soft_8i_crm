import '/core/enums/view_states.dart';
import '/core/services/crm/demandes_Product_list_service.dart';
import '/core/services/local_storage_service.dart';
import '../../../../locator.dart';
import '../../base_view_model.dart';

class DemandesProductListViewModel extends BaseViewModel {
  DemandesProductListService _demandesListService =
      locator<DemandesProductListService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> getProductsList(int startIndex, int fetchLimit) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getProductsList(startIndex, fetchLimit);
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> getProductsProspectList(String code) async {
    changeState(ViewState.Busy);
    var demandesResult =
        await _demandesListService.getProductsProspectList(code);
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
