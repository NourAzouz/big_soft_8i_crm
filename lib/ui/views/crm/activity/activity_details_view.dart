import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_Prospect_ACT_list_model.dart';
import '../../../../core/view_models/crm/activity/demande_activity_details_view_model.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/contact_support_alert_view.dart';
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

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
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
                                readOnly: false,
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
                                readOnly: false,
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
                                inputLabel: "Nom contact",
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
                                controller: _statutTextFormFieldController,
                                inputLabel: "Statut",
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
                                controller: _lieuTextFormFieldController,
                                inputLabel: "Localisation",
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
                                controller: _descriptionTextFormFieldController,
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
                              CustomTextField(
                                controller: _prioriteTextFormFieldController,
                                inputLabel: "priorite",
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
                                controller: _typeTextFormFieldController,
                                inputLabel: "Type",
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
                                controller: _typeATextFormFieldController,
                                inputLabel: "Type d'activite",
                                helperText: " ",
                                style: TextStyle(color: Colors.grey[600]),
                                readOnly: false,
                                enabled: true,
                                filled: true,
                                onTapAction: () =>
                                    showToast(fToast, toastMessage, context),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
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
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> getActivityDetails(
    DemandeActivityDetailsViewModel viewModel,
  ) async {
    var activityDetailsResult = await viewModel
        .getActivityDetails("${widget.ActivityDetailsViewArguments}");

    if (activityDetailsResult is DemandesActivityListModel) {
      setState(
        () {
          dataFinishLoading = true;
          _sujetTextFormFieldController.text =
              activityDetailsResult.sujet.toString();
          _dateDebutTextFormFieldController.text =
              activityDetailsResult.dateDebut.toString();
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