import '../../../../ui/views/crm/contact/demande_details_view.dart';

import '/core/enums/view_states.dart';
import '/core/services/crm/demandes_list_service.dart';
import '/core/services/local_storage_service.dart';

import '../../../../locator.dart';
import '../../base_view_model.dart';

class DemandesListViewModel extends BaseViewModel {
  final DemandesListService _demandesListService =
      locator<DemandesListService>();

  final DemandesListService _contactService = locator<DemandesListService>();

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

  Future<dynamic> getCollab() async {
    changeState(ViewState.Busy);
    var demandesResult = await _contactService.getCollab();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  updateContact(saveProspectArgument) {}
}
