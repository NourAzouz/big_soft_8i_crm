import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/core/models/demandes_Affaire_list_model.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/models/get_details_model.dart';
import '../../../../core/view_models/crm/affaire/demandes_Affaire_list_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<DemandesAffaireListModel> affairesResultsList;
late List<DemandesAffaireListModel> affairesToShowInListView;
var _affairesResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late DemandesAffaireListModel slectedAffaireSearchResult;
bool isAffairesListViewBusy = false;
bool isAffairesViewBusy = false;
late GlobalKey<FormState> _formKey;

List<DemandesAffaireListModel> getAffairesListToSearchFrom() {
  return affairesResultsList;
}

setAffaireToShowInListView(var affaire) {
  affairesToShowInListView.clear();
  affairesToShowInListView.add(affaire);
}

bool isLoadingAffaireDataError() {
  return dataLoadingError;
}

class DemandesAffaireListView extends StatefulWidget {
  late GlobalKey<FormState> _formKey;
  @override
  _DemandesAffaireListViewState createState() =>
      _DemandesAffaireListViewState();
}

class _DemandesAffaireListViewState extends State<DemandesAffaireListView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<DemandesAffaireListModel> affaires;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    affairesResultsList = [];
    affairesToShowInListView = [];
    dataLoadingError = false;
    affaires = affairesToShowInListView;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesAffaireListViewModel>(
      onModelReady: (viewModel) async {
        await getAffaires(viewModel: viewModel, context: context);
        // .whenComplete(() => startFeatureDiscovery(viewModel));
      },
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              // Here the height of the container is 28% of our total height
              height: size.height * .28,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.white,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                    Text(
                      "Affaires",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    buildSearch(),
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                    Expanded(
                      child: dataFinishLoading
                          ? SafeArea(
                              child: affairesResultsList.isNotEmpty
                                  ? NotificationListener<ScrollNotification>(
                                      onNotification: (onScrollNotification) {
                                        if (onScrollNotification
                                            is ScrollUpdateNotification) {
                                          isListViewScrollable = true;
                                          if (onScrollNotification
                                                      .metrics.pixels >
                                                  0 &&
                                              onScrollNotification
                                                  .metrics.atEdge) {
                                            fetchMoreData(
                                              viewModel,
                                              _scaffoldKey.currentState,
                                              context,
                                            );
                                          }
                                        }
                                        return true;
                                      },
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          await getAffaires(
                                            viewModel: viewModel,
                                            context: context,
                                            scaffoldState:
                                                _scaffoldKey.currentState,
                                          );
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: affaires,
                                          groupBy: (element) => element.nom,
                                          groupHeaderBuilder:
                                              (dynamic element) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 1,
                                            ),
                                            child: const Text(
                                              "",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          indexedItemBuilder: (context,
                                              dynamic element, index) {
                                            var circleAvatarIndex = index + 1;
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    '${affaires[index].nom}',
                                                  ),
                                                  subtitle: Text(
                                                    '${affaires[index].dateCr}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.purple,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                        "$circleAvatarIndex"),
                                                  ),
                                                  onTap: () => {
                                                    navigateToDemandeDetailsView(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      affaires[index],
                                                      viewModel,
                                                      _scaffoldKey.currentState,
                                                    ),
                                                  },
                                                ),
                                                const Divider(
                                                  height: 0,
                                                ),
                                                !paginationFinish &&
                                                        isListViewScrollable &&
                                                        index ==
                                                            affaires.length - 1
                                                    ? const Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Colors.purple,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () async {
                                        await getAffaires(
                                          viewModel: viewModel,
                                          context: context,
                                          scaffoldState:
                                              _scaffoldKey.currentState,
                                        );
                                      },
                                      child: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: Container(
                                          child: const Center(
                                            child: LoadingErrorView(
                                              imageURL:
                                                  "assets/images/add_file.png",
                                              errorMessage:
                                                  "Aucune Affaire enregistrée",
                                            ),
                                          ),
                                          height:
                                              SizeConfig.heightMultiplier * 86,
                                        ),
                                      ),
                                    ),
                            )
                          : dataLoadingError
                              ? SafeArea(
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      await getAffaires(
                                        viewModel: viewModel,
                                        context: context,
                                        scaffoldState:
                                            _scaffoldKey.currentState,
                                      );
                                    },
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Container(
                                        child: Center(
                                          child: LoadingErrorView(
                                            imageURL: "assets/images/error.png",
                                            errorMessage:
                                                dataLoadingErrorMessage,
                                          ),
                                        ),
                                        height:
                                            SizeConfig.heightMultiplier * 86,
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.purple),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchBar(
        text: query,
        hintText: 'N° ou Nom affaire',
        onChanged: searchAffaire,
      );

  void searchAffaire(String query) {
    final affaires = affairesToShowInListView.where((affaire) {
      final numeroAffaire = affaire.numero.toLowerCase();
      final nomAffaire = affaire.nom.toLowerCase();
      final search = query.toLowerCase();

      return numeroAffaire.contains(search) || nomAffaire.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.affaires = affaires;
    });
  }

  Future<void> getAffaires({
    required DemandesAffaireListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isAffairesListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _affairesResult = await viewModel.getDemandes(startIndex, fetchLimit);
    if (_affairesResult is List<DemandesAffaireListModel>) {
      if (isPagination) {
        affairesResultsList += _affairesResult;
        if (_affairesResult.isEmpty) paginationFinish = true;
      } else {
        affairesResultsList = _affairesResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      affairesToShowInListView.clear();
      for (var demande in affairesResultsList) {
        affairesToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_affairesResult is int) {
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
        dataLoadingErrorMessage = _affairesResult;
        dataLoadingError = true;
      });
      if (dataFinishLoading) {
        scaffoldState.showSnackBar(
          SnackBar(
            content: Text(
              dataLoadingErrorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
    isAffairesListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      await getAffaires(
        viewModel: viewModel,
        context: context,
        startIndex: _indexToStartPaginatingFrom,
        fetchLimit: _attachementFetchLimit,
        isPagination: true,
        scaffoldState: scaffoldState,
      );
      if (!dataLoadingError) {
        setState(() {
          _indexToStartPaginatingFrom += 25;
        });
      }
    }
  }

  navigateToDemandeDetailsView(BuildContext context,
      DemandesAffaireListModel affaire, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    DetailsModel detail =
        DetailsModel(code: affaire.numero, title: affaire.nom);
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_AFFAIRE_DETAILS_TAB_VIEW,
      arguments: detail,
    ).then(
      (_) async {
        affairesToShowInListView.clear();
        dataFinishLoading = false;
        await getAffaires(
          context: context,
          viewModel: viewModel,
        );
      },
    );
  }

  DemandeAffaireDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeAffaireDetailsViewArguments(
      nomAffaire: affairesToShowInListView[index].nom,
      numAffaire: affairesToShowInListView[index].numero,
      date: affairesToShowInListView[index].date,
      typePros: affairesToShowInListView[index].typePros,
      montant: affairesToShowInListView[index].montant,
      desc: affairesToShowInListView[index].desc,
      nomTiers: affairesToShowInListView[index].nomTiers,
      suivant: affairesToShowInListView[index].suivant,
      prob: affairesToShowInListView[index].prob,

      //prenomAffaire: demandesToShowInListView[index].prenomAffaire,
    );
  }
}

onPressAction(DemandesAffaireListViewModel viewModel, String code) async {}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeAffaireDetailsViewArguments {
  final String numAffaire;
  final String nomAffaire;
  final String date;
  final String montant;
  final String suivant;
  final String typePros;
  final String desc;
  final String nomTiers;
  final String prob;

  DemandeAffaireDetailsViewArguments(
      {required this.nomAffaire,
      required this.numAffaire,
      required this.date,
      required this.desc,
      required this.montant,
      required this.nomTiers,
      required this.prob,
      required this.suivant,
      required this.typePros});
}
