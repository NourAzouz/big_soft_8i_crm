import '../../../locator.dart';
import '../../enums/view_states.dart';
import '../../services/authentication_service.dart';
import '../../services/local_storage_service.dart';
import '../base_view_model.dart';

class UniteExerciceViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future<dynamic> getUnite() async {
    changeState(ViewState.Busy);
    var uniteResult = await _authenticationService.getUnite();
    changeState(ViewState.Idle);
    return uniteResult;
  }

  Future<dynamic> getExercice() async {
    changeState(ViewState.Busy);
    var exerciceResult = await _authenticationService.getExercice();
    changeState(ViewState.Idle);
    return exerciceResult;
  }

  Future<void> writeLibelleUniteAndLibelleExerciceToLocalStorage({
    required String libelleUnite,
    required String libelleExercice,
  }) async {
    changeState(ViewState.Busy);
    await _localStorageService
        .writeLibelleUniteAndLibelleExerciceToSecureStorage(
      libelleUnite: libelleUnite,
      libelleExercice: libelleExercice,
    );
    changeState(ViewState.Idle);
  }

  Future<dynamic> validateSessionAndFinishLoginProcess({
    required domaine,
    required username,
    required password,
    required codeUnite,
    required codeExercice,
    required anneeExercice,
  }) async {
    changeState(ViewState.Busy);
    var validateSessionResult =
        await _authenticationService.validateSessionAndFinishLoginProcess(
      domaine: domaine,
      username: username,
      password: password,
      codeUnite: codeUnite,
      codeExercice: codeExercice,
      anneeExercice: anneeExercice,
    );
    await _localStorageService.setValidateSessionResultToTrue();
    changeState(ViewState.Idle);
    return validateSessionResult;
  }

  Future<dynamic> logout() async {
    var logoutResult = await _authenticationService.logout();
    await _localStorageService.setValidateSessionResultToFalse();
    print(_localStorageService.isValidateSessionResult());
    return logoutResult;
  }
}
