import 'package:big_soft_8i_crm/core/view_models/base_view_model.dart';
import '../../../../locator.dart';
import '../../../../ui/views/crm/prospect/demande_Prospect_details_view.dart';
import '../../../enums/view_states.dart';
import '../../../services/crm/demandes_Prospect_list_service.dart';

class DemandeProspectDetailsViewModel extends BaseViewModel {
  DemandesProspectListService _demandesListService =
      locator<DemandesProspectListService>();

  Future<dynamic> getProspectDetails(String code) async {
    changeState(ViewState.Busy);
    var demandesResult = await _demandesListService.getProspectDetails(code);
    changeState(ViewState.Idle);
    return demandesResult;
  }

  final DemandesProspectListService _prospectService =
      locator<DemandesProspectListService>();
  Future<dynamic> updateContact(
    SaveProspectArgument saveProspectArgument,
  ) async {
    changeState(ViewState.Busy);
    var addContactResult =
        await _prospectService.updateProspectViewModel(saveProspectArgument);
    changeState(ViewState.Idle);
    return addContactResult;
  }
}
