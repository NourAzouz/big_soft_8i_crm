import '../../../../locator.dart';
import '../../../enums/view_states.dart';
import '../../../services/crm/demandes_Affaire_list_service.dart';
import '../../base_view_model.dart';

class DemandeAffaireDetailsViewModel extends BaseViewModel {
  DemandesAffaireListService _demandesListService =
      locator<DemandesAffaireListService>();

  Future<dynamic> getAffaireDetails(String code) async {
    changeState(ViewState.Busy);
    var demandesResult = await _demandesListService.getAffaireDetails(code);
    changeState(ViewState.Idle);
    return demandesResult;
  }
}
