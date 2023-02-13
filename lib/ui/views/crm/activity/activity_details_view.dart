import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_Prospect_ACT_list_model.dart';
import '../../../../core/view_models/crm/activity/demande_activity_details_view_model.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/contact_support_alert_view.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_flutter_toast.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loading_error_view.dart';
import '../../base_view.dart';

class ActivityDetailsView extends StatefulWidget {
  //const DemandeActivityDetailsView({Key? key}) : super(key: key);
  final ActivityDetailsViewArguments;

  const ActivityDetailsView({Key? key, this.ActivityDetailsViewArguments})
      : super(key: key);

  @override
  State<ActivityDetailsView> createState() => _ActivityDetailsViewState();
}

class _ActivityDetailsViewState extends State<ActivityDetailsView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _numTextFormFieldController;
  late TextEditingController _sujetTextFormFieldController;
  late TextEditingController _dateDebutTextFormFieldController;
  late TextEditingController _heureDebutTextFormFieldController;
  late TextEditingController _statutTextFormFieldController;
  late TextEditingController _lieuTextFormFieldController;
  late TextEditingController _nomContactTextFormFieldController;
  late TextEditingController _descriptionTextFormFieldController;
  late TextEditingController _prioriteTextFormFieldController;
  late TextEditingController _typeTextFormFieldController;
  late TextEditingController _typeATextFormFieldController;

  int _indexToStartPaginatingFrom = 25;
  int _dataFetchLimit = 25;

  late FToast fToast;
  static const toastMessage = "Impossible de modifier ce champ";

  late String codeDoc;
  late String codeParamProj;
  late String factureDepassement;
  late String typeProjet;
  late String type;
  late String montAtt;
  late String montantDepassement;

  late DemandesActivityListModel activityDetails;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  late String dataLoadingErrorMessage;

  Map<dynamic, String> prioMap = {'1': 'Haut', '2': 'Moyen', '3': 'Bas'};
  Map<dynamic, String> typeMap = {'A': 'Activité', 'T': 'Tâche'};
  Map<dynamic, String> typeacMap = {
    'AP': 'Appel',
    'CF': 'Conférence',
    'MC': 'Mobile Call'
  };
  Map<dynamic, String> statutMap = {
    '1': 'Planifiée',
    '2': 'A eu lieu',
    '3': "N'a pas eu lieu",
    '4': 'Non commencé',
    '5': 'En cours',
    '6': 'Terminé',
    '7': 'En attente',
    '8': 'Reporté',
    '9': 'Planifié'
  };

  //for dropdownmenu
  bool _canShowButton = true;
  bool _offstage = true;

  var date;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
      _offstage = !_offstage;
    });
  }

  //for dropdownmenu
  bool _canShowButton2 = true;
  bool _offstage2 = true;

  void hideWidget2() {
    setState(() {
      _canShowButton2 = !_canShowButton2;
      _offstage2 = !_offstage2;
    });
  }

  //for dropdownmenu
  bool _canShowButton3 = true;
  bool _offstage3 = true;

  void hideWidget3() {
    setState(() {
      _canShowButton3 = !_canShowButton3;
      _offstage3 = !_offstage3;
    });
  }

  //for dropdownmenu
  bool _canShowButton4 = true;
  bool _offstage4 = true;

  void hideWidget4() {
    setState(() {
      _canShowButton4 = !_canShowButton4;
      _offstage4 = !_offstage4;
    });
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    _numTextFormFieldController = TextEditingController();
    _sujetTextFormFieldController = TextEditingController();
    _dateDebutTextFormFieldController = TextEditingController();
    _heureDebutTextFormFieldController = TextEditingController();
    _statutTextFormFieldController = TextEditingController();
    _lieuTextFormFieldController = TextEditingController();
    _nomContactTextFormFieldController = TextEditingController();
    _descriptionTextFormFieldController = TextEditingController();
    _prioriteTextFormFieldController = TextEditingController();
    _typeTextFormFieldController = TextEditingController();
    _typeATextFormFieldController = TextEditingController();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _numTextFormFieldController.dispose();
    _sujetTextFormFieldController.dispose();
    _dateDebutTextFormFieldController.dispose();
    _heureDebutTextFormFieldController.dispose();
    _statutTextFormFieldController.dispose();
    _lieuTextFormFieldController.dispose();
    _nomContactTextFormFieldController.dispose();
    _descriptionTextFormFieldController.dispose();
    _prioriteTextFormFieldController.dispose();
    _typeTextFormFieldController.dispose();
    _typeATextFormFieldController.dispose();
    super.dispose();
  }

  onPressAction(
      DemandeActivityDetailsViewModel viewModel, scaffoldstate) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //if (_formKey.currentState!.validate()) {
    print(_dateDebutTextFormFieldController.text);
    var addProspectResult = await viewModel.updateContact(SaveActivityArgument(
        num: _numTextFormFieldController.text,
        sujet: _sujetTextFormFieldController.text,
        date: _dateDebutTextFormFieldController.text,
        assign: _nomContactTextFormFieldController.text,
        statut: "2",
        priorite: "2",
        type: "A",
        typeA: "CF",
        localisation: _lieuTextFormFieldController.text,
        description: _descriptionTextFormFieldController.text));
    //isAddProspectSuccess = true;
    //print(addProspectResult);
    /*
      if (addContactResult is bool) {
        setState(() {
          return isAddContactSuccess = true;
        });
      } else if (addContactResult is int) {
        showDialog(
          context: context,
          barrierDismissible: false,
          child: WillPopScope(
            onWillPop: () async => false,
            child: ContactSupportAlertView(),
          ),
        );
      } else {
        scaffoldstate.showSnackBar(
          SnackBar(
            content: Text(
              removeAllHtmlTags(addContactResult),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
   
   
   */
    //}
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DemandeActivityDetailsViewModel>(
      onModelReady: (viewModel) => getActivityDetails(viewModel),
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        body: dataFinishLoading
            ? SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 6),
                      Form(
                        key: _formKey,
                        child: AbsorbPointer(
                          absorbing: viewModel.state == ViewState.Busy,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: _sujetTextFormFieldController,
                                inputLabel: "Sujet",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: true,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _dateDebutTextFormFieldController,
                                inputLabel: "Date début",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: true,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              /*SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _heureDebutTextFormFieldController,
                                inputLabel: "Heure début",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),*/
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _nomContactTextFormFieldController,
                                inputLabel: "Assigné à",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                /*onTapAction: () =>
                                    showToast(fToast, toastMessage, context),*/
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              ///if the show button is false
                              !_canShowButton
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller:
                                          _statutTextFormFieldController,
                                      inputLabel: "Statut",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
                                      readOnly: false,
                                      enabled: true,
                                      filled: true,
                                      onTapAction: () {
                                        hideWidget();
                                      },
                                    ),
                              /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                              Offstage(
                                  offstage: _offstage,
                                  child: CustomDropdownField(
                                    labelText: "Statut ",
                                    items: <String>[
                                      'Planifiée',
                                      'A eu lieu',
                                      "N'a pas eu lieu",
                                      'Non commencé',
                                      'En cours',
                                      'Terminé',
                                      'En attente',
                                      'Reporté',
                                      'Planifié'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        value = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  )),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              ///if the show button is false
                              !_canShowButton2
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller:
                                          _prioriteTextFormFieldController,
                                      inputLabel: "priorité",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
                                      readOnly: false,
                                      enabled: true,
                                      filled: true,
                                      onTapAction: () {
                                        hideWidget2();
                                      },
                                    ),
                              /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                              Offstage(
                                  offstage: _offstage2,
                                  child: CustomDropdownField(
                                    labelText: "Priorité ",
                                    items: <String>['Haut', 'Moyen', 'Bas']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        value = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  )),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              ///if the show button is false
                              !_canShowButton3
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller: _typeTextFormFieldController,
                                      inputLabel: "Type",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
                                      readOnly: false,
                                      enabled: true,
                                      filled: true,
                                      onTapAction: () {
                                        hideWidget3();
                                      },
                                    ),
                              /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                              Offstage(
                                  offstage: _offstage3,
                                  child: CustomDropdownField(
                                    labelText: "Type ",
                                    items: <String>['Activité', 'Tâche']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        value = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  )),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              ///if the show button is false
                              !_canShowButton4
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller: _typeATextFormFieldController,
                                      inputLabel: "Type d'activité",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
                                      readOnly: false,
                                      enabled: true,
                                      filled: true,
                                      onTapAction: () {
                                        hideWidget4();
                                      },
                                    ),
                              /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                              Offstage(
                                  offstage: _offstage4,
                                  child: CustomDropdownField(
                                    labelText: "Type d'activité ",
                                    items: <String>[
                                      'Appel',
                                      'Conférence',
                                      'Mobile Call'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        value = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  )),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              CustomTextField(
                                controller: _lieuTextFormFieldController,
                                inputLabel: "Localisation",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                /*onTapAction: () =>
                                    showToast(fToast, toastMessage, context),*/
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _descriptionTextFormFieldController,
                                inputLabel: "Description",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                /*onTapAction: () =>
                                    showToast(fToast, toastMessage, context),*/
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : dataLoadingError
                ? SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await getActivityDetails(viewModel);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          child: Center(
                            child: LoadingErrorView(
                              imageURL: "assets/images/error.png",
                              errorMessage: dataLoadingErrorMessage,
                            ),
                          ),
                          height: SizeConfig.heightMultiplier * 77,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () async {
            await onPressAction(
              viewModel,
              _scaffoldKey.currentState,
            );
          },
        ),
      ),
    );
  }

  String? dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  Future<void> getActivityDetails(
    DemandeActivityDetailsViewModel viewModel,
  ) async {
    var activityDetailsResult = await viewModel
        .getActivityDetails("${widget.ActivityDetailsViewArguments}");

    if (activityDetailsResult is DemandesActivityListModel) {
      setState(
        () {
          dataFinishLoading = true;
          _numTextFormFieldController.text =
              activityDetailsResult.numero.toString();
          _sujetTextFormFieldController.text =
              activityDetailsResult.sujet.toString();
          _dateDebutTextFormFieldController.text =
              activityDetailsResult.dateDebut.toString();
          //date = activityDetailsResult.dateDebut;
          _heureDebutTextFormFieldController.text =
              activityDetailsResult.heureDebut.toString();
          _lieuTextFormFieldController.text =
              activityDetailsResult.lieu.toString();
          _statutTextFormFieldController.text =
              statutMap[activityDetailsResult.statut].toString();
          _nomContactTextFormFieldController.text =
              activityDetailsResult.nomContact.toString();
          _descriptionTextFormFieldController.text =
              activityDetailsResult.description.toString();
          _prioriteTextFormFieldController.text =
              prioMap[activityDetailsResult.priorite].toString();
          _typeTextFormFieldController.text =
              typeMap[activityDetailsResult.type].toString();
          _typeATextFormFieldController.text =
              typeacMap[activityDetailsResult.typeA].toString();
        },
      );
    } else if (activityDetailsResult is int) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const ContactSupportAlertView(),
          );
        },
      );
    } else {
      setState(() {
        dataLoadingErrorMessage = activityDetailsResult;
        dataLoadingError = true;
      });
    }
  }
}

class SaveActivityArgument {
  final String num;
  final String sujet;
  final String date;
  final String assign;
  final String statut;
  final String priorite;
  final String type;
  final String typeA;
  final String localisation;
  final String description;
  //final String devisText;
  //final String descriptionText;
  //final String nomCompteText;

  SaveActivityArgument({
    required this.num,
    required this.sujet,
    required this.date,
    required this.assign,
    required this.statut,
    required this.priorite,
    required this.type,
    required this.typeA,
    required this.localisation,
    required this.description,
    //required this.devisText,
    //required this.descriptionText,
    //required this.nomCompteText,
  });
}


/*

class DemandeActivityDetailsView extends StatelessWidget {
  final DemandesActivityListModel? demandeActivityDetailsViewArguments;
  final DemandesActivityListViewModel? viewModel;

  const DemandeActivityDetailsView(
      {Key? key, this.demandeActivityDetailsViewArguments, this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(demandeActivityDetailsViewArguments!.sujet),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Sujet :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeActivityDetailsViewArguments!.sujet))
                      ],
                    ),
                  )),

              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const  BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Date :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeActivityDetailsViewArguments!.dateDebut)
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Heur :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            '' + demandeActivityDetailsViewArguments!.heureDebut)
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Statut:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeActivityDetailsViewArguments!.statut)
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Lieu:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeActivityDetailsViewArguments!.lieu))
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Contact:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text('' +
                                demandeActivityDetailsViewArguments!.nomContact))
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan[500]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        const Text('Description:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeActivityDetailsViewArguments!.description))
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
            ],
          )),
    );
  }

}

*/