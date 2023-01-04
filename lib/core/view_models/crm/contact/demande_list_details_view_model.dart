import 'package:big_soft_8i_crm/core/view_models/base_view_model.dart';
import 'package:big_soft_8i_crm/locator.dart';

import '../../../enums/view_states.dart';

import '../../../services/crm/demandes_list_service.dart';

class DemandeListDetailsViewModel extends BaseViewModel {
  final DemandesListService _contactService = locator<DemandesListService>();

  Future<dynamic> getCollab() async {
    changeState(ViewState.Busy);
    var demandesResult = await _contactService.getCollab();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  Future<dynamic> getFunction() async {
    changeState(ViewState.Busy);
    var demandesResult = await _contactService.getFunction();
    changeState(ViewState.Idle);
    return demandesResult;
  }

  updateContact(saveProspectArgument) {}
}
