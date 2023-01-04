import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/view_states.dart';
import '../../../core/models/exercice_model.dart';
import '../../../core/models/unite_model.dart';
import '../../../core/view_models/auth/unite_exerice_view_model.dart';
import '../../shared/navigation_router_paths.dart';
import '../../shared/size_config.dart';
import '../../widgets/contact_support_alert_view.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/loading_error_view.dart';
import '../base_view.dart';

class UniteExerciceView extends StatefulWidget {
  const UniteExerciceView({
    Key? key,
  }) : super(key: key);
  @override
  _UniteExerciceViewState createState() => _UniteExerciceViewState();
}

class _UniteExerciceViewState extends State<UniteExerciceView> {
  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late GlobalKey<FormState> _formKey;
  List<UniteModel>? _uniteResultsList;
  List<ExerciceModel>? _exerciceResultsList;
  UniteModel? _uniteDropdownFieldValue;
  ExerciceModel? _exerciceDropdownFieldValue;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  String? dataLoadingErrorMessage;
  bool isViewBusy = false;

  String unknownErrorMessage =
      "une erreur est survenu lors du chargement des données contactez votre administrateur.";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _uniteResultsList = [];
    _exerciceResultsList = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UniteExerciceViewModel>(
      // TODO: Add the Future.delayed(Duration.zero,(){} to onModelReady to avoid problem with function calls & building widgets here & in StartupLogic view.
      onModelReady: (viewModel) => Future.delayed(Duration.zero, () {
        //your code goes here
        getUniteAndExercice(viewModel);
      }),
      builder: (context, viewModel, child) => WillPopScope(
        // TODO: Change the async methode to call showDialog by adding {} call showDialog in & adding a return true in the end of function call
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("BigSoft"),
                  content: const Text("Voulez-vous quitter l'application?"),
                  actions: <Widget>[
                    AbsorbPointer(
                      absorbing: isViewBusy,
                      child: TextButton(
                        child: const Text('Annuler'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: isViewBusy,
                      child: TextButton(
                        child: const Text('Confirmer'),
                        onPressed: () async {
                          setState(() {
                            isViewBusy = true;
                          });
                          // TODO: Return the removed await function to logout
                          //await viewModel.logout();
                          setState(() {
                            isViewBusy = false;
                          });
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
          return true;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: dataFinishLoading
                ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 6,
                    ),
                    child: AbsorbPointer(
                      absorbing: viewModel.state == ViewState.Busy,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: SizeConfig.heightMultiplier * 8),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Unité & Exercice',
                              style: TextStyle(
                                fontSize: SizeConfig.widthMultiplier * 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 8),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDropdownField(
                                  labelText: "Sélectionner l'unité",
                                  value: _uniteDropdownFieldValue,
                                  items: _uniteResultsList?.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value.libelleUnit),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChangedAction: (value) {
                                    setState(() {
                                      _uniteDropdownFieldValue = value!;
                                    });
                                  },
                                  validator: (value) => dropdownFieldValidation(
                                    value,
                                    "Veuillez sélectionner l'unité",
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 3),
                                CustomDropdownField(
                                  labelText: "Sélectionner l'exercice",
                                  value: _exerciceDropdownFieldValue,
                                  items: _exerciceResultsList?.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value.libelleExc),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChangedAction: (value) {
                                    setState(() {
                                      _exerciceDropdownFieldValue = value!;
                                    });
                                  },
                                  validator: (value) => dropdownFieldValidation(
                                    value,
                                    "Veuillez sélectionner l'exercice",
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  buttonText: "entrer",
                                  isBusy: viewModel.state == ViewState.Busy,
                                  onPressAction: () => onPressAction(
                                    context,
                                    _scaffoldKey.currentState,
                                    viewModel,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : dataLoadingError
                    ? LoadingErrorView(
                        imageURL: "assets/images/error.png",
                        errorMessage: dataLoadingErrorMessage,
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  void getUniteAndExercice(UniteExerciceViewModel viewModel) async {
    // TODO: Return the call of await function to get right result & remove the static one
    var _uniteResult = await viewModel.getUnite();

    // var _uniteResult =<UniteModel>[];
    if (_uniteResult is List<UniteModel>) {
      _uniteResultsList = _uniteResult;
      if (Constants.libelleUnite != null) {
        _uniteDropdownFieldValue = _uniteResultsList!.firstWhere(
          (unite) => unite.libelleUnit == Constants.libelleUnite,
          // TODO: Handle the error of return orElse & uncommet it
          //orElse: () =>null,
        );
      }
      // TODO: Return the call of await function & remove the static one
      var _exerciceResult = await viewModel.getExercice();
      //var _exerciceResult =1;
      if (_exerciceResult is List<ExerciceModel>) {
        _exerciceResultsList = _exerciceResult as List<ExerciceModel>?;
        // remove all exercice and keeps only the last one
        _exerciceResultsList!.removeRange(0, _exerciceResultsList!.length - 1);
        if (Constants.libelleExercice != null) {
          _exerciceDropdownFieldValue = _exerciceResultsList!.firstWhere(
            (exercice) => exercice.libelleExc == Constants.libelleExercice,
            // TODO: Handle the error of return orElse & uncommet it
            //orElse: () => null,
          );
        }
        setState(() {
          dataFinishLoading = true;
        });
      } else if (_exerciceResult is int) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => false,
            child: const ContactSupportAlertView(),
          ),
        );
      } else {
        setState(() {
          dataLoadingErrorMessage = _exerciceResult as String?;
          dataLoadingError = true;
        });
      }
    } else if (_uniteResult is int) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: const ContactSupportAlertView(),
        ),
      );
    } else {
      setState(() {
        dataLoadingErrorMessage = _uniteResult as String?;
        dataLoadingError = true;
      });
    }
    setState(() {
      dataFinishLoading = true;
    });
  }

  String? dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  onPressAction(
      context, scaffoldState, UniteExerciceViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      Constants.codeUnite = _uniteDropdownFieldValue!.codeUnit;
      Constants.libelleUnite = _uniteDropdownFieldValue!.libelleUnit;
      Constants.codeExercice = _exerciceDropdownFieldValue!.codeExc;
      Constants.anneeExercice = _exerciceDropdownFieldValue!.anneeExc;
      Constants.libelleExercice = _exerciceDropdownFieldValue!.libelleExc;
      // TODO: Uncomment the call of await function & remove the aff true
      var validateSessionResult =
          await viewModel.validateSessionAndFinishLoginProcess(
        domaine: Constants.domaine,
        username: Constants.username,
        password: Constants.password,
        codeUnite: Constants.codeUnite,
        codeExercice: Constants.codeExercice,
        anneeExercice: Constants.anneeExercice,
      );
      // var validateSessionResult = true;
      if (validateSessionResult is bool) {
        // TODO: Uncomment the code
        await viewModel.writeLibelleUniteAndLibelleExerciceToLocalStorage(
          libelleUnite: Constants.libelleUnite!,
          libelleExercice: Constants.libelleExercice!,
        );
        Navigator.pushReplacementNamed(
          context,
          NavigationRouterPaths.ROOT_VIEW,
        );
      } else if (validateSessionResult is int) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => false,
            child: const ContactSupportAlertView(),
          ),
        );
      } else {
        scaffoldState.showSnackBar(
          SnackBar(
            content: Text(
              /*validateSessionResult ??*/ unknownErrorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
    /*Navigator.pushReplacementNamed(
      context,
      NavigationRouterPaths.ROOT_VIEW,
    );*/
  }
}
