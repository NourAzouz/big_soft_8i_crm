import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/core/models/demandes_contact_list_model.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/models/demandes_list_model.dart';
import '../../../../core/view_models/crm/contact/demandes_list_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<DemandesContactListModel> demandesResultsList;
late List<DemandesContactListModel> demandesToShowInListView;
late List<DemandesCollabListModel> demandescollabResultsList;

var _demandesResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late DemandesContactListModel slectedDemandeSearchResult;
bool isDemandesListViewBusy = false;
bool isDemandesViewBusy = false;
late GlobalKey<FormState> _formKey;

List<DemandesContactListModel> getDemandesListToSearchFrom() {
  return demandesResultsList;
}

setDemandeToShowInListView(var demande) {
  demandesToShowInListView.clear();
  demandesToShowInListView.add(demande);
}

bool isLoadingDemandeDataError() {
  return dataLoadingError;
}

class DemandesListView extends StatefulWidget {
  late GlobalKey<FormState> _formKey;
  @override
  _DemandesListViewState createState() => _DemandesListViewState();
}

class _DemandesListViewState extends State<DemandesListView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<DemandesContactListModel> demandes;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    demandesResultsList = [];
    demandescollabResultsList = [];
    demandesToShowInListView = [];
    dataLoadingError = false;
    demandes = demandesToShowInListView;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesListViewModel>(
      onModelReady: (viewModel) async {
        await getDemandes(viewModel: viewModel, context: context);
        //.whenComplete(() => startFeatureDiscovery(viewModel));
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
                    Colors.blue,
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
                      "Contacts",
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
                              child: demandesResultsList.isNotEmpty
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
                                          await getDemandes(
                                            viewModel: viewModel,
                                            context: context,
                                            scaffoldState:
                                                _scaffoldKey.currentState,
                                          );
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: demandes,
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
                                                    '${demandes[index].nom}',
                                                  ),
                                                  subtitle: Text(
                                                    '${demandes[index].telephone}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                        "$circleAvatarIndex"),
                                                  ),
                                                  onTap: () => {
                                                    navigateToDemandeDetailsView(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      demandes[index],
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
                                                            demandes.length - 1
                                                    ? const Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Colors.blue,
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
                                        await getDemandes(
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
                                                  "Aucune demande enregistrée",
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
                                      await getDemandes(
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
                                        Colors.blue),
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
        hintText: 'N° ou  Nom contact',
        onChanged: searchDemande,
      );

  void searchDemande(String query) {
    final demandes = demandesToShowInListView.where((demande) {
      final numCompte = demande.numcompte.toLowerCase();
      final nomTiers = demande.nomTiers.toLowerCase();
      final prenomTiers = demande.prenom.toLowerCase();
      final search = query.toLowerCase();

      return numCompte.contains(search) ||
          nomTiers.contains(search) ||
          prenomTiers.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.demandes = demandes;
    });
  }

  Future<void> getDemandes({
    required DemandesListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    var demandescollabResults = await viewModel.getCollab();

    isDemandesListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _demandesResult = await viewModel.getDemandes(startIndex, fetchLimit);
    print(_demandesResult);
    if (_demandesResult is List<DemandesContactListModel>) {
      if (isPagination) {
        demandescollabResultsList = demandescollabResults;
        demandesResultsList += _demandesResult;
        if (_demandesResult.isEmpty) paginationFinish = true;
      } else {
        demandesResultsList = _demandesResult;
        demandescollabResultsList = demandescollabResults;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      demandesToShowInListView.clear();
      for (var demande in demandesResultsList) {
        demandesToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_demandesResult is int) {
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
        dataLoadingErrorMessage = _demandesResult;
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
    isDemandesListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      await getDemandes(
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

  /*
  Future<void> startFeatureDiscovery(DemandesListViewModel viewModel) async {
    bool _isFeatureDiscoveryAlreadySeen =
        await viewModel.isFeatureDiscoveryAlreadySeen();
    if (!_isFeatureDiscoveryAlreadySeen) {
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{'fabFeature'},
      );
      viewModel.setFeatureDiscoveryAlreadySeenToTrue();
    }
  }
  */
  navigateToDemandeDetailsView(BuildContext context,
      DemandesContactListModel demande, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_DETAILS_TAB_VIEW,
      arguments: demande,
    ).then(
      (_) async {
        demandesToShowInListView.clear();
        dataFinishLoading = false;
        await getDemandes(
          context: context,
          viewModel: viewModel,
        );
      },
    );
  }

  DemandeDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeDetailsViewArguments(
        prenom: demandesToShowInListView[index].prenom,
        nom: demandesToShowInListView[index].nom,
        numCompte: demandesToShowInListView[index].numcompte,
        compte: demandesToShowInListView[index].compte,
        mail: demandesToShowInListView[index].mail,
        telephone: demandesToShowInListView[index].telephone,
        fix: demandesToShowInListView[index].fix,
        codeTiers: demandesToShowInListView[index].codeTiers,
        nomTiers: demandesToShowInListView[index].nomTiers,
        superieur: demandesToShowInListView[index].superieur,
        service: demandesToShowInListView[index].service,
        telBureau: demandesToShowInListView[index].telBureau,
        disc: demandesToShowInListView[index].disc,
        fonction: demandesToShowInListView[index].fonction,
        demandesCollabResultsList: demandescollabResultsList);
  }
}

onPressAction(DemandesListViewModel viewModel, String code) async {
  var dd = await viewModel.deleteDemande(code);
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeDetailsViewArguments {
  final String numCompte;
  final String compte;
  final String nom;
  final String prenom;
  final String telephone;
  final String mail;
  final String fix;
  final String codeTiers;
  final String nomTiers;
  final String telBureau;
  final String service;
  final String superieur;
  final String disc;
  final String fonction;

  final List<DemandesCollabListModel> demandesCollabResultsList;

  DemandeDetailsViewArguments({
    required this.fonction,
    required this.numCompte,
    required this.compte,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.mail,
    required this.fix,
    required this.codeTiers,
    required this.nomTiers,
    required this.service,
    required this.superieur,
    required this.telBureau,
    required this.disc,
    required this.demandesCollabResultsList,
  });
}
