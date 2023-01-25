import 'package:big_soft_8i_crm/core/view_models/base_view_model.dart';

import '../../../../locator.dart';
import '../../../../ui/views/crm/compte/demande_Compte_details_view.dart';
import '../../../enums/view_states.dart';
import '../../../services/crm/demandes_compte_service.dart';

class DemandeCompteDetailsViewModel extends BaseViewModel {
  final DemandesCompteListService _prospectService =
      locator<DemandesCompteListService>();
  Future<dynamic> updateContact(
    SaveCompteArgument saveProspectArgument,
  ) async {
    changeState(ViewState.Busy);
    var addContactResult =
        await _prospectService.updateProspectViewModel(saveProspectArgument);
    changeState(ViewState.Idle);
    return addContactResult;
  }

  Future<dynamic> getAssg() async {
    changeState(ViewState.Busy);
    var demandesResult = await _prospectService.getAssg();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> getSect() async {
    changeState(ViewState.Busy);
    var demandesResult = await _prospectService.getSect();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> getDev() async {
    changeState(ViewState.Busy);
    var demandesResult = await _prospectService.getdev();
    changeState(ViewState.Idle);
    return demandesResult;
  }
}
