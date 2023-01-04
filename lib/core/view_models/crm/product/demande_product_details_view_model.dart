import 'package:big_soft_8i_crm/core/view_models/base_view_model.dart';

import '../../../../locator.dart';
import '../../../../ui/views/crm/product/demande_Product_details_view.dart';
import '../../../enums/view_states.dart';
import '../../../services/crm/demandes_Product_list_service.dart';

class DemandeProductDetailsViewModel extends BaseViewModel {
  final DemandesProductListService _prospectService =
      locator<DemandesProductListService>();
  Future<dynamic> updateContact(
    SaveProductArgument saveProspectArgument,
  ) async {
    changeState(ViewState.Busy);
    var addContactResult =
        await _prospectService.updateProspectViewModel(saveProspectArgument);
    changeState(ViewState.Idle);
    return addContactResult;
  }
}
