import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_Prospect_list_model.dart';
import '../../../../core/view_models/crm/prospect/demande_prospect_details_view_model.dart';
import '../../../shared/navigation_router_paths.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/contact_support_alert_view.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_flutter_toast.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loading_error_view.dart';
import '../../base_view.dart';

class DemandeProspectDetailsView extends StatefulWidget {
  final demandeProspectDetailsViewArguments;
  const DemandeProspectDetailsView(
      {Key? key, this.demandeProspectDetailsViewArguments})
      : super(key: key);

  @override
  State<DemandeProspectDetailsView> createState() =>
      _DemandeProspectDetailsViewState();
}

class _DemandeProspectDetailsViewState
    extends State<DemandeProspectDetailsView> {
  bool isAddProspectSuccess = false;

  late List<DemandesOrgListModel> orgResultsList; /////////
  late List<SectListModel> sectResultsList;
  late List<AssgListModel> assgResultsList;

  List<DropdownMenuItem<Object?>> _dropdownTestItems = []; ///////////
  String? orgselectedValue;
  String? sectselectedValue;
  String? assgselectedValue;

  //for dropdownmenu ////////////////////////////////
  bool _canShowButton = true;
  bool _offstage = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
      _offstage = !_offstage;
    });
  }

  bool _canShowButton2 = true;
  bool _offstage2 = true;

  void hideWidget2() {
    setState(() {
      _canShowButton2 = !_canShowButton2;
      _offstage2 = !_offstage2;
    });
  }

  bool _canShowButton3 = true;
  bool _offstage3 = true;

  void hideWidget3() {
    setState(() {
      _canShowButton3 = !_canShowButton3;
      _offstage3 = !_offstage3;
    });
  }

  late GlobalKey<ScaffoldMessengerState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _numProspectTextFormFieldController;
  late TextEditingController _nomProspectTextFormFieldController;
  late TextEditingController _prenomProspectTextFormFieldController;
  late TextEditingController _titreTextFormFieldController;
  late TextEditingController _telTextFormFieldController;
  late TextEditingController _mailTextFormFieldController;
  late TextEditingController _societeTextFormFieldController;
  late TextEditingController _origineProspectTextFormFieldController;
  late TextEditingController _libSecteurActiviteTextFormFieldController;
  late TextEditingController _chiffreAffaireTextFormFieldController;
  late TextEditingController _nbrempTextFormFieldController;
  late TextEditingController _collabTextFormFieldController;
  late TextEditingController _noteTextFormFieldController;
  late TextEditingController _statutTextFormFieldController;
  late TextEditingController _descriptionTextFormController;

  int _indexToStartPaginatingFrom = 25;
  int _dataFetchLimit = 25;

  late FToast fToast;
  static const toastMessage = "Impossible de modifier ce champ";

  late String _codeDoc;
  late String codeParamProj;
  late String factureDepassement;
  late String typeProjet;
  late String type;
  late String montAtt;
  late String montantDepassement;

  late DemandesProspectListModel activityDetails;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  late String dataLoadingErrorMessage;

  @override
  void initState() {
    super.initState();

    orgResultsList = [];
    sectResultsList = [];
    assgResultsList = [];

    _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    _formKey = GlobalKey<FormState>();
    _numProspectTextFormFieldController = TextEditingController();
    _nomProspectTextFormFieldController = TextEditingController();
    _prenomProspectTextFormFieldController = TextEditingController();
    _titreTextFormFieldController = TextEditingController();
    _telTextFormFieldController = TextEditingController();
    _mailTextFormFieldController = TextEditingController();
    _societeTextFormFieldController = TextEditingController();
    _origineProspectTextFormFieldController = TextEditingController();
    _libSecteurActiviteTextFormFieldController = TextEditingController();
    _chiffreAffaireTextFormFieldController = TextEditingController();
    _nbrempTextFormFieldController = TextEditingController();
    _collabTextFormFieldController = TextEditingController();
    _noteTextFormFieldController = TextEditingController();
    _statutTextFormFieldController = TextEditingController();
    _descriptionTextFormController = TextEditingController();
    /*
    _numProspectTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.numProspect.toString();
    _nomProspectTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.nomProspect.toString();
    _prenomProspectTextFormFieldController.text =  widget.demandeProspectDetailsViewArguments!.prenomProspect.toString();
    _telTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.tel.toString();
    _titreTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.titre.toString();
    _mailTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.mail.toString();
    _societeTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.societe.toString();
    _origineProspectTextFormFieldController.text =  widget.demandeProspectDetailsViewArguments!.origineProspect.toString();
    _libSecteurActiviteTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.libSecteurActivite.toString();
    _chiffreAffaireTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.chiffreAffaire.toString();
    _nbrempTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.nbremp.toString();
    _collabTextFormFieldController.text = widget.demandeProspectDetailsViewArguments!.collab.toString();
  */

    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _numProspectTextFormFieldController.dispose();
    _nomProspectTextFormFieldController.dispose();
    _prenomProspectTextFormFieldController.dispose();
    _titreTextFormFieldController.dispose();
    _telTextFormFieldController.dispose();
    _mailTextFormFieldController.dispose();
    _societeTextFormFieldController.dispose();
    _origineProspectTextFormFieldController.dispose();
    _libSecteurActiviteTextFormFieldController.dispose();
    _chiffreAffaireTextFormFieldController.dispose();
    _nbrempTextFormFieldController.dispose();
    _collabTextFormFieldController.dispose();
    _noteTextFormFieldController.dispose();
    _statutTextFormFieldController.dispose();
    _descriptionTextFormController.dispose();
    super.dispose();
  }

  onPressAction(
      DemandeProspectDetailsViewModel viewModel, scaffoldstate) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      var addProspectResult = await viewModel.updateContact(
        SaveProspectArgument(
          numProspect: _numProspectTextFormFieldController.text,
          nomProspect: _nomProspectTextFormFieldController.text,
          prenomProspect: _prenomProspectTextFormFieldController.text,
          telText: _telTextFormFieldController.text,
          mail: _mailTextFormFieldController.text,
          societe: _mailTextFormFieldController.text,
          titre: _titreTextFormFieldController.text,
          description: _descriptionTextFormController.text,
        ),
      );
      isAddProspectSuccess = true;
      print(addProspectResult);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DemandeProspectDetailsViewModel>(
      onModelReady: (viewModel) => getProspectDetails(viewModel, context),
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
                                controller: _numProspectTextFormFieldController,
                                inputLabel: "Numero",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _nomProspectTextFormFieldController,
                                inputLabel: "Nom & prenom",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _titreTextFormFieldController,
                                inputLabel: "Titre",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _telTextFormFieldController,
                                inputLabel: "Téléphone",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                suffixIcon: GestureDetector(
                                  onTap: () => _makePhoneCall(
                                      _telTextFormFieldController.text),
                                  child: const Icon(Icons.phone),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
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
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _societeTextFormFieldController,
                                inputLabel: "Société",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              //////////////////////////////////////////////
                              ///if the show button is false
                              !_canShowButton
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller:
                                          _origineProspectTextFormFieldController,
                                      inputLabel: "Origine",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
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
                                  labelText: "Origine",
                                  value: orgselectedValue,
                                  items: orgResultsList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.orgp),
                                    );
                                  }).toList(),
                                  onChangedAction: (value) {
                                    setState(() {
                                      orgselectedValue = value!;
                                    });
                                  },
                                  validator: (value) => dropdownFieldValidation(
                                    value,
                                    "Selectionne une fonction",
                                  ),
                                ),
                              ),
                              ////////////////////////////////////////////////
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              //////////////////////////////////////////////
                              ///if the show button is false
                              !_canShowButton2
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller:
                                          _libSecteurActiviteTextFormFieldController,
                                      inputLabel: "Secteur d'activité",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
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
                                  labelText: "Secteur d'activité",
                                  value: sectselectedValue,
                                  items: sectResultsList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.libelle),
                                    );
                                  }).toList(),
                                  onChangedAction: (value) {
                                    setState(() {
                                      orgselectedValue = value!;
                                    });
                                  },
                                  validator: (value) => dropdownFieldValidation(
                                    value,
                                    "Selectionne une fonction",
                                  ),
                                ),
                              ),
                              /////////////////////////////////////////////
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              //////////////////////////////////////////////
                              ///if the show button is false
                              !_canShowButton3
                                  ? const SizedBox.shrink()
                                  : CustomTextField(
                                      controller:
                                          _collabTextFormFieldController,
                                      inputLabel: "Assigné à ",
                                      helperText: " ",
                                      style: TextStyle(color: Colors.grey[600]),
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
                                  labelText: "Secteur d'activité",
                                  value: assgselectedValue,
                                  items: assgResultsList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.nompresup),
                                    );
                                  }).toList(),
                                  onChangedAction: (value) {
                                    setState(() {
                                      orgselectedValue = value!;
                                    });
                                  },
                                  validator: (value) => dropdownFieldValidation(
                                    value,
                                    "Selectionne une fonction",
                                  ),
                                ),
                              ),
                              ////////////////////////////////////
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller:
                                    _chiffreAffaireTextFormFieldController,
                                inputLabel: "Chiffre d'affaire",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _nbrempTextFormFieldController,
                                inputLabel: "Nombre d'employés",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              CustomTextField(
                                controller: _descriptionTextFormController,
                                inputLabel: "Description",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              // CustomTextField(
                              //   controller:
                              //       _noteTextFormFieldController,
                              //   inputLabel: "Note",
                              //   helperText: " ",
                              //   style: TextStyle(color: Colors.grey[600]),
                              //   readOnly: false,
                              //   enabled: true,
                              //   filled: true,
                              //   onTapAction: () =>
                              //       showToast(fToast, toastMessage, context),
                              // ),
                              // SizedBox(height: SizeConfig.heightMultiplier * 2),
                              // CustomTextField(
                              //   controller:
                              //       _statutTextFormFieldController,
                              //   inputLabel: "Status",
                              //   helperText: " ",
                              //   style: TextStyle(color: Colors.grey[600]),
                              //   readOnly: false,
                              //   enabled: true,
                              //   filled: true,
                              //   onTapAction: () =>
                              //       showToast(fToast, toastMessage, context),
                              // ),
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
                        await getProspectDetails(viewModel, context);
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          children: [
            SpeedDialChild(
                child: const Icon(FontAwesomeIcons.calendarDays),
                backgroundColor: Colors.red,
                label: 'Activities ',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, NavigationRouterPaths.Demandes_Activity_list,
                      arguments: _codeDoc);
                }),
            SpeedDialChild(
                child: const Icon(FontAwesomeIcons.productHunt),
                backgroundColor: Colors.blue,
                label: 'Produits',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, NavigationRouterPaths.Demandes_Product_list,
                      arguments: _codeDoc);
                }),
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
            /*SpeedDialChild(
                child: const Icon(Icons.auto_stories),
                backgroundColor: Colors.green,
                label: 'Ajoute Une Activitie',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, NavigationRouterPaths.Ajout_Activity);
                }),*/
          ],
        ),
        /*FloatingActionButton(
          child: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, NavigationRouterPaths.Demandes_Activity_list,
                arguments: _codeDoc);
          },
        ),*/
      ),
    );
  }

  String? dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  Future<void> getProspectDetails(
      DemandeProspectDetailsViewModel viewModel, BuildContext context) async {
    var orgResults = await viewModel.getorg();
    var sectResults = await viewModel.getsect();
    var assgResults = await viewModel.getassg();

    var prospectDetailsResult = await viewModel
        .getProspectDetails("${widget.demandeProspectDetailsViewArguments}");
    //print(prospectDetailsResult);
    if (prospectDetailsResult is DemandesProspectListModel) {
      setState(
        () {
          orgResultsList = orgResults;
          sectResultsList = sectResults;
          assgResultsList = assgResults;

          ///////////////////////////////////////////////
          dataFinishLoading = true;
          _numProspectTextFormFieldController.text =
              prospectDetailsResult.numProspect.toString();
          _nomProspectTextFormFieldController.text =
              prospectDetailsResult.nomProspect.toString() +
                  " " +
                  prospectDetailsResult.prenomProspect.toString();
          _telTextFormFieldController.text =
              prospectDetailsResult.tel.toString();
          _titreTextFormFieldController.text =
              prospectDetailsResult.titre.toString();
          _mailTextFormFieldController.text =
              prospectDetailsResult.mail.toString();
          _societeTextFormFieldController.text =
              prospectDetailsResult.societe.toString();
          _origineProspectTextFormFieldController.text =
              prospectDetailsResult.origineProspect.toString();
          _libSecteurActiviteTextFormFieldController.text =
              prospectDetailsResult.libSecteurActivite.toString();
          _chiffreAffaireTextFormFieldController.text =
              prospectDetailsResult.chiffreAffaire.toString();
          _nbrempTextFormFieldController.text =
              prospectDetailsResult.nbremp.toString();
          _collabTextFormFieldController.text =
              prospectDetailsResult.collab.toString();
          _noteTextFormFieldController.text =
              prospectDetailsResult.note.toString();
          _statutTextFormFieldController.text =
              prospectDetailsResult.status.toString();
          _descriptionTextFormController.text =
              prospectDetailsResult.description.toString();
          _codeDoc = prospectDetailsResult.codeProspect;
        },
      );
    } else if (prospectDetailsResult is int) {
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
        dataLoadingErrorMessage = prospectDetailsResult;
        dataLoadingError = true;
      });
    }
  }
}

DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(value: item, child: Text(item));

class SaveProspectArgument {
  final String numProspect;
  final String nomProspect;
  final String prenomProspect;
  final String telText;
  final String titre;
  final String mail;
  final String societe;
  final String description;

  SaveProspectArgument({
    required this.numProspect,
    required this.nomProspect,
    required this.prenomProspect,
    required this.telText,
    required this.titre,
    required this.mail,
    required this.societe,
    required this.description,
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
/*
class DemandeProspectDetailsView extends StatelessWidget {
  final DemandesProspectListModel? demandeProspectDetailsViewArguments;
  final DemandesProspectListViewModel? viewModel;

  const DemandeProspectDetailsView(
      {Key? key, this.demandeProspectDetailsViewArguments, this.viewModel})
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
          title: Text(demandeProspectDetailsViewArguments!.nomProspect),
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
                      const Text('Code du Propsect :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text('' +
                              demandeProspectDetailsViewArguments!.numProspect))
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      const Text('Nom du Prospect :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('' + demandeProspectDetailsViewArguments!.nomProspect)
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
                      const Text('Prenom du Prospect:'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('' +
                          demandeProspectDetailsViewArguments!.prenomProspect)
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
                      const Text('Titre:'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('' + demandeProspectDetailsViewArguments!.titre)
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
                      const Text('Telephone:'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                              '' + demandeProspectDetailsViewArguments!.tel))
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
                      const Text('Email :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                              '' + demandeProspectDetailsViewArguments!.mail))
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
                      const Text('Societé :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                              '' + demandeProspectDetailsViewArguments!.societe))
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
                      const Text('Propsect Original :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text('' +
                              demandeProspectDetailsViewArguments
                                  !.origineProspect))
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
                      const Text('Secteur :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text('' +
                              demandeProspectDetailsViewArguments
                                  !.libSecteurActivite))
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
                      const Text('Chiffre d Affaires :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text('' +
                              demandeProspectDetailsViewArguments
                                  !.chiffreAffaire))
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
                      const Text('Nomber d employe :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                              '' + demandeProspectDetailsViewArguments!.nbremp))
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
                      const Text('Assigné à :'),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                              '' + demandeProspectDetailsViewArguments!.collab))
                    ],
                  ),
                )),
            const SizedBox(height: 10),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child:const Icon(Icons.list) ,
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, NavigationRouterPaths.Demandes_Activity_list);
          },
        ),
      ),
    );
  }
}
*/
