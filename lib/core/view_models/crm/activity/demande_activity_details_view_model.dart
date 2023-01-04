import 'package:big_soft_8i_crm/core/view_models/base_view_model.dart';

import '../../../../locator.dart';
import '../../../enums/view_states.dart';
import '../../../services/crm/demandes_Activity_list_service.dart';
import '../../../services/local_storage_service.dart';

class DemandeActivityDetailsViewModel extends BaseViewModel {
  DemandesActivityListService _demandesListService =
      locator<DemandesActivityListService>();

  Future<dynamic> getActivityDetails(String code) async {
    changeState(ViewState.Busy);
    var demandesResult = await _demandesListService.getActivityDetails(code);
    changeState(ViewState.Idle);
    return demandesResult;
  }
}
