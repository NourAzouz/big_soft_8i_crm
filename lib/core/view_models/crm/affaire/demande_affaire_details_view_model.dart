import '../../../../locator.dart';
import '../../../../ui/views/crm/affaire/demande_Affaires_details_view.dart';
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

  Future<dynamic> getRel() async {
    changeState(ViewState.Busy);
    var demandesResult = await _demandesListService.getrel();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> updateAffaire(
    SaveAffaireArgument saveAffaireArgument,
  ) async {
    changeState(ViewState.Busy);
    var addContactResult =
        await _demandesListService.updateAffaireViewModel(saveAffaireArgument);
    changeState(ViewState.Idle);
    return addContactResult;
  }
}
