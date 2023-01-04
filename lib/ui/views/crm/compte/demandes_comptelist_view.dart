import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/models/demandes_compte_model.dart';
import '../../../../core/view_models/crm/compte/demandes_CompteList_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<DemandesCompteListModel> comptesResultsList;
late List<DemandesCompteListModel> comptesToShowInListView;
var _comptesResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late DemandesCompteListModel slectedCompteSearchResult;
bool isComptesListViewBusy = false;
bool isComptesViewBusy = false;
late GlobalKey<FormState> _formKey;

List<DemandesCompteListModel> getComptesListToSearchFrom() {
  return comptesResultsList;
}

setComptesToShowInListView(var compte) {
  comptesToShowInListView.clear();
  comptesToShowInListView.add(compte);
}

bool isLoadingCompteDataError() {
  return dataLoadingError;
}

class DemandesCompteListView extends StatefulWidget {
  late GlobalKey<FormState> _formKey;
  @override
  _DemandesCompteListViewState createState() => _DemandesCompteListViewState();
}

class _DemandesCompteListViewState extends State<DemandesCompteListView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<DemandesCompteListModel> comptes;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    comptesResultsList = [];
    comptesToShowInListView = [];
    dataLoadingError = false;
    comptes = comptesToShowInListView;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesCompteListViewModel>(
      onModelReady: (viewModel) async {
        await getComptes(viewModel: viewModel, context: context);
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
                      "Comptes",
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
                              child: comptesResultsList.isNotEmpty
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
                                          await getComptes(
                                            viewModel: viewModel,
                                            context: context,
                                            scaffoldState:
                                                _scaffoldKey.currentState,
                                          );
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: comptes,
                                          groupBy: (element) =>
                                              element.nomTiers,
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
                                                    '${comptes[index].nomTiers.toString()}',
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
                                                      comptes[index],
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
                                                            comptes.length - 1
                                                    ? const Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
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
                                        await getComptes(
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
                                                  "Aucun compte enregistré",
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
                                      await getComptes(
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
        hintText: 'N° ou nom tiers',
        onChanged: searchCompte,
      );

  void searchCompte(String query) {
    final comptes = comptesToShowInListView.where((compte) {
      final numTiers = compte.codeTiers.toLowerCase();
      final nomTiers = compte.nomTiers.toLowerCase();
      final search = query.toLowerCase();

      return numTiers.contains(search) || nomTiers.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.comptes = comptes;
    });
  }

  Future<void> getComptes({
    required DemandesCompteListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isComptesListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _comptesResult = await viewModel.getDemandes(startIndex, fetchLimit);

    if (_comptesResult is List<DemandesCompteListModel>) {
      if (isPagination) {
        comptesResultsList += _comptesResult;
        if (_comptesResult.isEmpty) paginationFinish = true;
      } else {
        comptesResultsList = _comptesResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      comptesToShowInListView.clear();
      for (var demande in comptesResultsList) {
        comptesToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_comptesResult is int) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: ContactSupportAlertView(),
          );
        },
      );
    } else {
      setState(() {
        dataLoadingErrorMessage = _comptesResult;
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
    isComptesListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      await getComptes(
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
      DemandesCompteListModel compte, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_COMPTE_DETAILS_TAB_VIEW,
      arguments: compte,
    ).then(
      (_) async {
        comptesToShowInListView.clear();
        dataFinishLoading = false;
        await getComptes(
          context: context,
          viewModel: viewModel,
        );
      },
    );
  }

  DemandeCompteDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeCompteDetailsViewArguments(
      codeTiers: comptesToShowInListView[index].codeTiers,
      nomTiers: comptesToShowInListView[index].nomTiers,
      assign: comptesToShowInListView[index].assign,
      mail: comptesToShowInListView[index].mail,
      secteur: comptesToShowInListView[index].secteur,
      prop: comptesToShowInListView[index].prop,
      effictife: comptesToShowInListView[index].effic,
      tel: comptesToShowInListView[index].tel,
      revenue: comptesToShowInListView[index].revenue,
      devise: comptesToShowInListView[index].devis,
    );
  }
}

onPressAction(DemandesCompteListViewModel viewModel, String code) async {
  viewModel.deleteDemande(code);
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeCompteDetailsViewArguments {
  final String codeTiers;
  final String nomTiers;
  final String assign;
  final String mail;
  final String secteur;
  final String prop;
  final String effictife;
  final String tel;
  final String revenue;
  final String devise;

  DemandeCompteDetailsViewArguments({
    required this.codeTiers,
    required this.nomTiers,
    required this.assign,
    required this.mail,
    required this.tel,
    required this.secteur,
    required this.devise,
    required this.effictife,
    required this.prop,
    required this.revenue,
  });
}
