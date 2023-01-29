import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/enums/view_states.dart';
import '../../../../core/models/demandes_Product_list_model.dart';
import '../../../../core/view_models/crm/product/demande_product_details_view_model.dart';
import '../../../shared/size_config.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_flutter_toast.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loading_error_view.dart';
import '../../base_view.dart';

class DemandeProductDetailsView extends StatefulWidget {
  final demandeProductDetailsViewArguments;
  const DemandeProductDetailsView(
      {Key? key, this.demandeProductDetailsViewArguments})
      : super(key: key);

  @override
  State<DemandeProductDetailsView> createState() =>
      _DemandeProductDetailsViewState();
}

class _DemandeProductDetailsViewState extends State<DemandeProductDetailsView> {
  late List<TVAListModel> tvaResultsList;
  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  String? tvaselectedValue;

  late List<CatListModel> catResultsList;
  String? catselectedValue;

  //for dropdownmenu ////////////////////////////////
  bool _canShowButton = true;
  bool _offstage = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
      _offstage = !_offstage;
    });
  }

  //for dropdownmenu ////////////////////////////////
  bool _canShowButton2 = true;
  bool _offstage2 = true;

  void hideWidget2() {
    setState(() {
      _canShowButton2 = !_canShowButton2;
      _offstage2 = !_offstage2;
    });
  }

  late GlobalKey<ScaffoldMessengerState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _codeArticleTextFormFieldController;
  late TextEditingController _libelleTextFormFieldController;
  late TextEditingController _familleTextFormFieldController;
  late TextEditingController _referenceTextFormFieldController;
  late TextEditingController _stockTextFormFieldController;
  late TextEditingController _modeleTextFormFieldController;
  late TextEditingController _prixTextFormFieldController;
  late TextEditingController _siteWebTextFormFieldController;
  late TextEditingController _codeBarresTextFormFieldController;
  late TextEditingController _tvaTextFormFieldController;
  bool isAddProspectSuccess = false;

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

  late ProductsProductListModel activityDetails;
  bool dataFinishLoading = true;
  bool dataLoadingError = false;
  late String dataLoadingErrorMessage;

  @override
  void initState() {
    super.initState();

    catResultsList = [];
    tvaResultsList = [];

    _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    _formKey = GlobalKey<FormState>();
    _codeArticleTextFormFieldController = TextEditingController();
    _libelleTextFormFieldController = TextEditingController();
    _familleTextFormFieldController = TextEditingController();
    _referenceTextFormFieldController = TextEditingController();
    _stockTextFormFieldController = TextEditingController();
    _modeleTextFormFieldController = TextEditingController();
    _prixTextFormFieldController = TextEditingController();
    _siteWebTextFormFieldController = TextEditingController();
    _codeBarresTextFormFieldController = TextEditingController();
    _tvaTextFormFieldController = TextEditingController();
    _codeArticleTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.codeArticle.toString();
    _libelleTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.libelle.toString();
    _familleTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.famille.toString();
    _stockTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.stock.toString();
    _referenceTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.reference.toString();
    _modeleTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.modele.toString();
    _prixTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.prix.toString();
    _siteWebTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.siteWeb.toString();
    _codeBarresTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.codeBarres.toString();
    _tvaTextFormFieldController.text =
        widget.demandeProductDetailsViewArguments!.tva.toString();

    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _codeArticleTextFormFieldController.dispose();
    _libelleTextFormFieldController.dispose();
    _familleTextFormFieldController.dispose();
    _referenceTextFormFieldController.dispose();
    _stockTextFormFieldController.dispose();
    _modeleTextFormFieldController.dispose();
    _prixTextFormFieldController.dispose();
    _siteWebTextFormFieldController.dispose();
    _codeBarresTextFormFieldController.dispose();
    _tvaTextFormFieldController.dispose();
    super.dispose();
  }

  onPressAction(DemandeProductDetailsViewModel viewModel, scaffoldstate) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      var addProspectResult = await viewModel.updateContact(
        SaveProductArgument(
          codeArticle: _codeArticleTextFormFieldController.text,
          libelleText: _libelleTextFormFieldController.text,
          familleText: _familleTextFormFieldController.text,
          referenceText: _referenceTextFormFieldController.text,
          stockText: _stockTextFormFieldController.text,
          modeleText: _modeleTextFormFieldController.text,
          prixText: _prixTextFormFieldController.text,
          siteWebText: _siteWebTextFormFieldController.text,
          codeBarresText: _codeBarresTextFormFieldController.text,
          tvaText: _tvaTextFormFieldController.text,
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
    return BaseView<DemandeProductDetailsViewModel>(
      //onModelReady: (viewModel) => getActivityDetails(viewModel, context),
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
                                  controller:
                                      _codeArticleTextFormFieldController,
                                  inputLabel: "Code article",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _libelleTextFormFieldController,
                                  inputLabel: "Produit",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _modeleTextFormFieldController,
                                  inputLabel: "Modele",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  /*onTapAction: () =>
                                      showToast(fToast, toastMessage, context),*/
                                ),

                                ///if the show button is false
                                /*!_canShowButton2
                                    ? const SizedBox.shrink()
                                    : CustomTextField(
                                        controller:
                                            _familleTextFormFieldController,
                                        inputLabel: "Categorie",
                                        helperText: " ",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        readOnly: false,
                                        enabled: true,
                                        filled: true,
                                        onTapAction: () {
                                          hideWidget2();
                                          //_number();
                                        },
                                      ),
                                SizedBox(
                                      height: SizeConfig.heightMultiplier * 3),*/
                                /*Offstage(
                                  offstage: _offstage2,
                                  child: CustomDropdownField(
                                    labelText: "Categorie",
                                    value: catselectedValue,
                                    items: catResultsList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.codeCat),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        catselectedValue = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),*/

                                /*SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _stockTextFormFieldController,
                                  inputLabel: "Stock",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  onTapAction: () =>
                                      showToast(fToast, toastMessage, context),
                                ),*/
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _referenceTextFormFieldController,
                                  inputLabel: "Référence",
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
                                  controller: _siteWebTextFormFieldController,
                                  inputLabel: "Site Web",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  /*onTapAction: () =>
                                      showToast(fToast, toastMessage, context),*/
                                ),

                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller: _prixTextFormFieldController,
                                  inputLabel: "Prix",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  /*onTapAction: () =>
                                      showToast(fToast, toastMessage, context),*/
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),
                                CustomTextField(
                                  controller:
                                      _codeBarresTextFormFieldController,
                                  inputLabel: "Code Barres",
                                  helperText: " ",
                                  style: TextStyle(color: Colors.grey[600]),
                                  readOnly: false,
                                  enabled: true,
                                  filled: true,
                                  /*onTapAction: () =>
                                      showToast(fToast, toastMessage, context),*/
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),

                                ///if the show button is false
                                /*!_canShowButton
                                    ? const SizedBox.shrink()
                                    : CustomTextField(
                                        controller: _tvaTextFormFieldController,
                                        inputLabel: "Tva",
                                        helperText: " ",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
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
                                    labelText: "TVA",
                                    value: tvaselectedValue,
                                    items: tvaResultsList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.codeTva),
                                      );
                                    }).toList(),
                                    onChangedAction: (value) {
                                      setState(() {
                                        catselectedValue = value!;
                                      });
                                    },
                                    validator: (value) =>
                                        dropdownFieldValidation(
                                      value,
                                      "Selectionne une fonction",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 2),*/
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
                          await getActivityDetails(viewModel, context);
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
                  : dataLoadingError
                      ? SafeArea(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await getActivityDetails(viewModel, context);
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
                                AlwaysStoppedAnimation<Color>(Colors.blue),
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

  String? dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  Future<void> getActivityDetails(
      DemandeProductDetailsViewModel viewModel, BuildContext context) async {
    var tvaResults = await viewModel.getTva();
    var catResults = await viewModel.getCat();
    setState(
      () {
        catResultsList = catResults;

        tvaResultsList = tvaResults;
        /* _codeArticleTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.codeArticle.toString();
        _libelleTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.dateInitf.toString();
        _familleTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.heureDebut.toString();
        _stockTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.lieu.toString();
        _referenceTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.statut.toString();
        _modeleTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.nomContact.toString();
        _prixTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.description.toString();

        _siteWebTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.siteWeb.toString();
        _codeBarresTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.codeBarres.toString();
        _tvaTextFormFieldController.text =
            widget.demandeProductDetailsViewArguments!.tva.toString();
        dataFinishLoading = true;*/
      },
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(value: item, child: Text(item));

class SaveProductArgument {
  final String codeArticle;
  final String libelleText;
  final String familleText;
  final String stockText;
  final String referenceText;
  final String modeleText;
  final String prixText;
  final String siteWebText;
  final String codeBarresText;
  final String tvaText;

  SaveProductArgument({
    required this.codeArticle,
    required this.libelleText,
    required this.familleText,
    required this.stockText,
    required this.referenceText,
    required this.modeleText,
    required this.prixText,
    required this.siteWebText,
    required this.codeBarresText,
    required this.tvaText,
  });
} 

/*
class DemandeProductDetailsView extends StatelessWidget {
  final ProductsProductListModel? demandeProductDetailsViewArguments;
  final DemandesProductListViewModel? viewModel;

  const DemandeProductDetailsView(
      {Key? key, this.demandeProductDetailsViewArguments, this.viewModel})
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
            title: Text(demandeProductDetailsViewArguments!.libelle),
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
                        const Text('Code Article :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text('' +
                                demandeProductDetailsViewArguments!.codeArticle))
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
                        const Text('Libelle :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeProductDetailsViewArguments!.libelle)
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
                        const Text('famille :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeProductDetailsViewArguments!.famille)
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
                        const Text('Reference:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('' + demandeProductDetailsViewArguments!.reference)
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
                        const Text('Stock:'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeProductDetailsViewArguments!.stock))
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
                        const Text('Modele :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeProductDetailsViewArguments!.modele))
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
                        const Text('Prix :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeProductDetailsViewArguments!.prix))
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
                        const Text('Site Web :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text('' +
                                demandeProductDetailsViewArguments!.siteWeb))
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
                        const Text('Code Barres :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text('' +
                                demandeProductDetailsViewArguments!.codeBarres))
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
                        const Text('TVA :'),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                                '' + demandeProductDetailsViewArguments!.tva))
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