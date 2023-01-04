import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_compte_model.dart';
import '../../../../core/view_models/crm/compte/demande_compte_details_view_model.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/custom_flutter_toast.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loading_error_view.dart';
import '../../base_view.dart';

class DemandeCompteDetailsView extends StatefulWidget {
  final demandeCompteDetailsViewArguments;

  const DemandeCompteDetailsView(
      {Key? key, this.demandeCompteDetailsViewArguments})
      : super(key: key);

  @override
  State<DemandeCompteDetailsView> createState() =>
      _DemandeCompteDetailsViewState();
}

class _DemandeCompteDetailsViewState extends State<DemandeCompteDetailsView> {
  bool isAddProspectSuccess = false;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nomCompteTextFormFieldController;
  late TextEditingController _assignTextFormFieldController;
  late TextEditingController _telephoneTextFormFieldController;
  late TextEditingController _mailTextFormFieldController;
  late TextEditingController _secteurTextFormFieldController;
  late TextEditingController _propritaireTextFormFieldController;
  late TextEditingController _effictifeTextFormFieldController;
  late TextEditingController _revenueTextFormFieldController;
  late TextEditingController _devisTextFormFieldController;
  late TextEditingController _descriptionTextFormController;

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

  late DemandesCompteListModel activityDetails;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  late String dataLoadingErrorMessage;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    _nomCompteTextFormFieldController = TextEditingController();
    _assignTextFormFieldController = TextEditingController();
    _telephoneTextFormFieldController = TextEditingController();
    _mailTextFormFieldController = TextEditingController();
    _secteurTextFormFieldController = TextEditingController();
    _propritaireTextFormFieldController = TextEditingController();
    _effictifeTextFormFieldController = TextEditingController();
    _revenueTextFormFieldController = TextEditingController();
    _devisTextFormFieldController = TextEditingController();
    _descriptionTextFormController = TextEditingController();
    _nomCompteTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.codeTiers.toString();
    _assignTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.assign.toString();
    _telephoneTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.tel.toString();
    _secteurTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.secteur.toString();
    _mailTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.mail.toString();
    _propritaireTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.prop.toString();
    _effictifeTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.effic.toString();
    _revenueTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.revenue.toString();
    _devisTextFormFieldController.text =
        widget.demandeCompteDetailsViewArguments!.devis.toString();
    _descriptionTextFormController.text =
        widget.demandeCompteDetailsViewArguments!.description.toString();

    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _nomCompteTextFormFieldController.dispose();
    _assignTextFormFieldController.dispose();
    _telephoneTextFormFieldController.dispose();
    _mailTextFormFieldController.dispose();
    _secteurTextFormFieldController.dispose();
    _propritaireTextFormFieldController.dispose();
    _effictifeTextFormFieldController.dispose();
    _revenueTextFormFieldController.dispose();
    _devisTextFormFieldController.dispose();
    super.dispose();
  }

  onPressAction(DemandeCompteDetailsViewModel viewModel, scaffoldstate) async {
    scaffoldstate.hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      var addProspectResult = await viewModel.updateContact(
        SaveCompteArgument(
          nomCompteText: _nomCompteTextFormFieldController.text,
          assignText: _assignTextFormFieldController.text,
          telephoneText: _telephoneTextFormFieldController.text,
          mailText: _mailTextFormFieldController.text,
          secteurText: _secteurTextFormFieldController.text,
          propritaireText: _propritaireTextFormFieldController.text,
          effictifeText: _effictifeTextFormFieldController.text,
          revenueText: _revenueTextFormFieldController.text,
          devisText: _devisTextFormFieldController.text,
          descriptionText: _descriptionTextFormController.text,
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
    return BaseView<DemandeCompteDetailsViewModel>(
      //onModelReady: (viewModel) => getCompteDetails(viewModel),
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
                                  controller: _nomCompteTextFormFieldController,
                                  inputLabel: "Nom du Compte",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _assignTextFormFieldController,
                                  inputLabel: "Assigné a",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _telephoneTextFormFieldController,
                                  inputLabel: "Telephone",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  suffixIcon: GestureDetector(
                                    onTap: () => _makePhoneCall(
                                        _telephoneTextFormFieldController.text),
                                    child: const Icon(Icons.phone),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _mailTextFormFieldController,
                                  inputLabel: "Mail",
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
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _secteurTextFormFieldController,
                                  inputLabel: "Secteur",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller:
                                      _propritaireTextFormFieldController,
                                  inputLabel: "Propritaire",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _effictifeTextFormFieldController,
                                  inputLabel: "Effictife",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _revenueTextFormFieldController,
                                  inputLabel: "Revenue Anuelle",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _devisTextFormFieldController,
                                  inputLabel: "Devise",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
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
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
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
                          await getCompteDetails(viewModel);
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
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.purple),
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
          )),
    );
  }

  Future<void> getCompteDetails(
    DemandeCompteDetailsViewModel viewModel,
  ) async {
    setState(
      () {
        _nomCompteTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.codeTiers.toString();
        _assignTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.assign.toString();
        _telephoneTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.tel.toString();
        _secteurTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.secteur.toString();
        _mailTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.mail.toString();
        _propritaireTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.prop.toString();
        _effictifeTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.effic.toString();
        _revenueTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.revenue.toString();
        _devisTextFormFieldController.text =
            widget.demandeCompteDetailsViewArguments!.devis.toString();
        _descriptionTextFormController.text =
            widget.demandeCompteDetailsViewArguments!.description.toString();
        dataFinishLoading = true;
      },
    );
  }
}

class SaveCompteArgument {
  final String nomCompteText;
  final String assignText;
  final String telephoneText;
  final String secteurText;
  final String mailText;
  final String propritaireText;
  final String effictifeText;
  final String revenueText;
  final String devisText;
  final String descriptionText;

  SaveCompteArgument({
    required this.nomCompteText,
    required this.assignText,
    required this.telephoneText,
    required this.secteurText,
    required this.mailText,
    required this.propritaireText,
    required this.effictifeText,
    required this.revenueText,
    required this.devisText,
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


/*
class DemandeCompteDetailsView extends StatelessWidget {
  final DemandesCompteListModel? demandeAnesDetailsViewArguments;
  final DemandesCompteListViewModel? viewModel;

  const DemandeCompteDetailsView({
    Key? key,
    this.demandeAnesDetailsViewArguments,
    this.viewModel,
  }) : super(key: key);

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
            title: Text(demandeAnesDetailsViewArguments!.nomTiers),
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
                        const Text('Nom du Compte :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeAnesDetailsViewArguments!.codeTiers))
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
                        const Text('assigne a  :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.assign)
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
                        const Text('Telephone :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.tel)
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
                        const Text('Mail :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.mail)
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
                        Text('' + demandeAnesDetailsViewArguments!.secteur)
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
                        const Text('Propritaire :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.prop)
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
                        const Text('Effictife :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.effic)
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
                        const Text('Revenue Anuelle :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.revenue)
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
                        const Text('Devise :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeAnesDetailsViewArguments!.devis)
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
*/