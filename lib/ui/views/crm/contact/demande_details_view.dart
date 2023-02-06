import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_list_model.dart';
import '../../../../core/view_models/crm/contact/demande_list_details_view_model.dart';
import '../../../../core/view_models/crm/contact/demandes_list_view_model.dart';
import '../../../shared/navigation_router_paths.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_flutter_toast.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loading_error_view.dart';

import 'dart:async';

import '../../base_view.dart';

class DemandeDetailsView extends StatefulWidget {
  final demandeDetailsViewArguments;

  const DemandeDetailsView({Key? key, this.demandeDetailsViewArguments})
      : super(key: key);

  @override
  State<DemandeDetailsView> createState() => _DemandeDetailsViewState();
}

class _DemandeDetailsViewState extends State<DemandeDetailsView> {
  late List<DemandesCollabListModel> demandesResultsList;
  late List<SupListModel> supResultsList;
  late List<FonctionListModel> fonctionResultsList;
  String? functionselectedValue;

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];

  late GlobalKey<ScaffoldMessengerState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _numCompteTextFormFieldController;
  late TextEditingController _nomTiersTextFormFieldController;
  late TextEditingController _assigneTextFormFieldController;
  late TextEditingController _fonctionTextFormFieldController;

  late TextEditingController _nomTextFormFieldController;
  late TextEditingController _prenomTextFormFieldController;
  late TextEditingController _telephoneTextFormFieldController;
  late TextEditingController _mailTextFormFieldController;
  late TextEditingController _telBureauTextFormFieldController;
  late TextEditingController _serviceTextFormFieldController;
  late TextEditingController _superieurTextFormFieldController;
  late TextEditingController _descriptionTextFormFieldController;

  late FToast fToast;
  static const toastMessage = "Impossible de modifier ce champ";

  late String codeDoc;
  late String codeParamProj;
  late String factureDepassement;
  late String typeProjet;
  late String type;
  late String montAtt;
  late String montantDepassement;
  late List<String> L;

  // late DemandesContactListModel activityDetails;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  bool dataFinishLoading1 = true;
  bool dataLoadingError1 = false;
  late String dataLoadingErrorMessage;
  var selectedValue;
  var value;

  //for dropdownmenu
  bool _canShowButton = true;
  bool _offstage = true;

  bool _canShowButton2 = true;
  bool _offstage2 = true;

  bool _canShowButton3 = true;
  bool _offstage3 = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
      _offstage = !_offstage;
    });
  }

  void hideWidget2() {
    setState(() {
      _canShowButton2 = !_canShowButton2;
      _offstage2 = !_offstage2;
    });
  }

  void hideWidget3() {
    setState(() {
      _canShowButton3 = !_canShowButton3;
      _offstage3 = !_offstage3;
    });
  }

  @override
  void initState() {
    super.initState();

    dataLoadingErrorMessage = '';
    demandesResultsList = [];
    fonctionResultsList = [];
    supResultsList = [];

    L = [];
    _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    _formKey = GlobalKey<FormState>();
    _numCompteTextFormFieldController = TextEditingController();
    _nomTiersTextFormFieldController = TextEditingController();
    _nomTextFormFieldController = TextEditingController();
    _prenomTextFormFieldController = TextEditingController();
    _telephoneTextFormFieldController = TextEditingController();
    _mailTextFormFieldController = TextEditingController();
    _telBureauTextFormFieldController = TextEditingController();
    _serviceTextFormFieldController = TextEditingController();
    _superieurTextFormFieldController = TextEditingController();
    _descriptionTextFormFieldController = TextEditingController();
    _assigneTextFormFieldController = TextEditingController();
    _fonctionTextFormFieldController = TextEditingController();

    _numCompteTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.numcompte.toString();
    _nomTiersTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.nomTiers.toString();
    _nomTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.nom.toString();
    _telephoneTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.telephone.toString();
    _prenomTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.prenom.toString();
    _mailTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.mail.toString();
    _telBureauTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.telBureau.toString();
    _serviceTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.service.toString();
    _superieurTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.superieur.toString();
    _descriptionTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.disc.toString();
    _fonctionTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.fonction.toString();
    _assigneTextFormFieldController.text =
        widget.demandeDetailsViewArguments!.assigne.toString();

    /*functionselectedValue =
        widget.demandeDetailsViewArguments!.fonction.toString();*/

    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _numCompteTextFormFieldController.dispose();
    _nomTiersTextFormFieldController.dispose();
    _nomTextFormFieldController.dispose();
    _prenomTextFormFieldController.dispose();
    _telephoneTextFormFieldController.dispose();
    _mailTextFormFieldController.dispose();
    _telBureauTextFormFieldController.dispose();
    _serviceTextFormFieldController.dispose();
    _superieurTextFormFieldController.dispose();
    _descriptionTextFormFieldController.dispose();
    _assigneTextFormFieldController.dispose();
    _fonctionTextFormFieldController.dispose();
    super.dispose();
  }

  onPressAction(DemandeListDetailsViewModel viewModel, scaffoldstate) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //if (_formKey.currentState!.validate()) {
    var addProspectResult = await viewModel.updateContact(SaveContactArgument(
      numCompte: _numCompteTextFormFieldController.text,
      nomText: _nomTextFormFieldController.text,
      prenomText: _prenomTextFormFieldController.text,
      telephoneText: _telephoneTextFormFieldController.text,
      telBureauText: _telBureauTextFormFieldController.text,
      superieurText: _superieurTextFormFieldController.text,
      mailText: _mailTextFormFieldController.text,
      descriptionText: _descriptionTextFormFieldController.text,
      nomTiers: _nomTiersTextFormFieldController.text,
    ));
    var isAddProspectSuccess = true;
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
    return BaseView<DemandeListDetailsViewModel>(
        onModelReady: (viewModel) => getDemandeDetails(viewModel, context),
        builder: (context, viewModel, child) => Scaffold(
            key: _scaffoldKey,
            body: dataFinishLoading
                ? SafeArea(
                    child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await getDemandeDetails(viewModel, context);
                      },
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
                                    controller:
                                        _numCompteTextFormFieldController,
                                    inputLabel: "N° Contact",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: true,
                                    enabled: true,
                                    filled: true,
                                    onTapAction: () => showToast(
                                        fToast, toastMessage, context),
                                    child: null,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller:
                                        _nomTiersTextFormFieldController,
                                    inputLabel: "Nom Compte",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    /*onTapAction: () => showToast(
                                        fToast, toastMessage, context),*/
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller: _nomTextFormFieldController,
                                    inputLabel: "Nom",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    /*onTapAction: () => showToast(
                                        fToast, toastMessage, context),*/
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller: _prenomTextFormFieldController,
                                    inputLabel: "Prénom",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    /*onTapAction: () => showToast(
                                        fToast, toastMessage, context),*/
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller:
                                        _telephoneTextFormFieldController,
                                    inputLabel: "Téléphone",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () => _makePhoneCall(
                                          _telephoneTextFormFieldController
                                              .text),
                                      child: const Icon(Icons.phone),
                                    ),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),
                                  CustomTextField(
                                    controller:
                                        _telBureauTextFormFieldController,
                                    inputLabel: "Téléphone bureau",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () => _makePhoneCall(
                                          _telephoneTextFormFieldController
                                              .text),
                                      child: const Icon(Icons.phone),
                                    ),
                                    child: null,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller: _mailTextFormFieldController,
                                    inputLabel: "Email",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () => _makeMail(
                                          _mailTextFormFieldController.text),
                                      child: const Icon(Icons.mail),
                                    ),
                                    child: null,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),

                                  ///if the show button is false
                                  !_canShowButton3
                                      ? const SizedBox.shrink()
                                      : CustomTextField(
                                          controller:
                                              _superieurTextFormFieldController,
                                          inputLabel: "Supérieur",
                                          helperText: " ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          readOnly: false,
                                          enabled: true,
                                          filled: true,
                                          onTapAction: () {
                                            hideWidget3();
                                            //_number();
                                          },
                                        ),
                                  /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                                  Offstage(
                                    offstage: _offstage3,
                                    child: CustomDropdownField(
                                      labelText: "Supérieur",
                                      value: value,
                                      items: supResultsList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value.nompresup),
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
                                        "Selectionne un superieur",
                                      ),
                                    ),
                                  ),

                                  ///if the show button is false

                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),

                                  ///if the show button is false
                                  !_canShowButton
                                      ? const SizedBox.shrink()
                                      : CustomTextField(
                                          controller:
                                              _fonctionTextFormFieldController,
                                          inputLabel: "Fonction",
                                          helperText: " ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          readOnly: false,
                                          enabled: true,
                                          filled: true,
                                          onTapAction: () {
                                            hideWidget();
                                            //_number();
                                          },
                                        ),
                                  /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                                  Offstage(
                                    offstage: _offstage,
                                    child: CustomDropdownField(
                                      labelText: "Fonction ",
                                      value: functionselectedValue,
                                      items: fonctionResultsList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value.libellefonction),
                                        );
                                      }).toList(),
                                      onChangedAction: (value) {
                                        setState(() {
                                          functionselectedValue = value!;
                                        });
                                      },
                                      validator: (value) =>
                                          dropdownFieldValidation(
                                        value,
                                        "Selectionne une fonction",
                                      ),
                                    ),
                                  ),

                                  /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  Text(
                                    _superieurTextFormFieldController.text
                                        .toString(),
                                    selectionColor: Colors.black,
                                  ),*/
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),

                                  !_canShowButton2
                                      ? const SizedBox.shrink()
                                      : CustomTextField(
                                          controller:
                                              _assigneTextFormFieldController,
                                          inputLabel: "Assigné à",
                                          helperText: " ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          readOnly: false,
                                          enabled: true,
                                          filled: true,
                                          onTapAction: () {
                                            hideWidget2();
                                            //_number();
                                          },
                                        ),
                                  /*SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                                  Offstage(
                                    offstage: _offstage2,
                                    child: CustomDropdownField(
                                      labelText: "Assigné à",
                                      value: selectedValue,
                                      items: L.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChangedAction: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                      validator: (value) =>
                                          dropdownFieldValidation(
                                        value,
                                        "Veuillez assigne quelqun",
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  CustomTextField(
                                    controller:
                                        _descriptionTextFormFieldController,
                                    inputLabel: "Description",
                                    helperText: " ",
                                    style: TextStyle(color: Colors.grey[600]),
                                    readOnly: false,
                                    enabled: true,
                                    filled: true,
                                    /*onTapAction: () => showToast(
                                        fToast, toastMessage, context),
                                    child: null,*/
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                : RefreshIndicator(
                    onRefresh: () async {
                      await getDemandeDetails(viewModel, context);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier * 86,
                        child: const Center(
                          child: LoadingErrorView(
                            imageURL: "assets/images/add_file.png",
                            errorMessage: "Aucune contac",
                          ),
                        ),
                      ),
                    ),
                  ),
            floatingActionButton:
                SpeedDial(animatedIcon: AnimatedIcons.menu_home, children: [
              SpeedDialChild(
                child: const Icon(FontAwesomeIcons.floppyDisk),
                backgroundColor: Colors.blue,
                label: 'Save',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () async {
                  await onPressAction(
                    viewModel,
                    _scaffoldKey.currentState,
                  );
                },
              ),
            ])));
  }

  String? dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  Future<void> getDemandeDetails(
      DemandeListDetailsViewModel viewModel, BuildContext context) async {
    var demandesResults = await viewModel.getCollab();
    var fonctionResults = await viewModel.getFunction();
    var supResults = await viewModel.getsup();

    setState(
      () {
        demandesResultsList = demandesResults;
        fonctionResultsList = fonctionResults;
        supResultsList = supResults;
        //print(fonctionResults);
        for (var inu in demandesResultsList) {
          L.add(inu.codeCollab.toString());
        }

        dataFinishLoading = true;
      },
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(value: item, child: Text(item));

class SaveContactArgument {
  final String numCompte;
  final String nomTiers;
  final String nomText;
  final String telephoneText;
  final String prenomText;
  final String mailText;
  final String telBureauText;
  //final String serviceText;
  final String superieurText;
  final String descriptionText;

  SaveContactArgument({
    required this.numCompte,
    required this.nomTiers,
    required this.nomText,
    required this.telephoneText,
    required this.prenomText,
    required this.mailText,
    required this.telBureauText,
    //required this.serviceText,
    required this.superieurText,
    required this.descriptionText,
  });
}

Future<void> _makePhoneCall(String phoneNumber) async {
  if (phoneNumber != "") {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

Future<void> _makeMail(String phoneNumber) async {
  if (phoneNumber != "") {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
