import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/core/models/demandes_Prospect_list_model.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/models/get_details_model.dart';
import '../../../../core/view_models/crm/prospect/demandes_Prospect_list_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<DemandesProspectListModel> prospectsResultsList;
late List<DemandesProspectListModel> prospectsToShowInListView;
var _prospectsResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late DemandesProspectListModel slectedProspectsSearchResult;
bool isProspectsListViewBusy = false;
bool isProspectsViewBusy = false;
late GlobalKey<FormState> _formKey;

List<DemandesProspectListModel> getProspectsListToSearchFrom() {
  return prospectsResultsList;
}

setProspectToShowInListView(var demande) {
  prospectsToShowInListView.clear();
  prospectsToShowInListView.add(demande);
}

bool isLoadingProspectDataError() {
  return dataLoadingError;
}

class DemandesProspectListView extends StatefulWidget {
  late GlobalKey<FormState> _formKey;
  @override
  _DemandesProspectListViewState createState() =>
      _DemandesProspectListViewState();
}

class _DemandesProspectListViewState extends State<DemandesProspectListView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<DemandesProspectListModel> prospects;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    prospectsResultsList = [];
    prospectsToShowInListView = [];
    dataLoadingError = false;
    prospects = prospectsToShowInListView;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesProspectListViewModel>(
      onModelReady: (viewModel) async {
        await getProspectsList(viewModel: viewModel, context: context);
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
                      "Prospects",
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
                              child: prospectsResultsList.isNotEmpty
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
                                          await getProspectsList(
                                            viewModel: viewModel,
                                            context: context,
                                            scaffoldState:
                                                _scaffoldKey.currentState,
                                          );
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: prospects,
                                          groupBy: (element) =>
                                              element.nomProspect,
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
                                                    '${prospects[index].nomProspect} ${prospects[index].prenomProspect}',
                                                  ),
                                                  subtitle: Text(
                                                    '${prospects[index].societe}',
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
                                                      prospects[index],
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
                                                            prospects.length - 1
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
                                        await getProspectsList(
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
                                                  "Aucune demande prospect enregistrée",
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
                                      await getProspectsList(
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
        hintText: 'N°, Nom, Prénom prospect ou société',
        onChanged: searchProspect,
      );

  void searchProspect(String query) {
    final prospects = prospectsToShowInListView.where((client) {
      final numProspect = client.numProspect.toLowerCase();
      final nomProspect = client.nomProspect.toLowerCase();
      final prenomProspect = client.prenomProspect.toLowerCase();
      final societeProspect = client.societe.toLowerCase();
      final search = query.toLowerCase();

      return numProspect.contains(search) ||
          nomProspect.contains(search) ||
          prenomProspect.contains(search) ||
          societeProspect.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.prospects = prospects;
    });
  }

  Future<void> getProspectsList({
    required DemandesProspectListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isProspectsListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _prospectsResult = await viewModel.getProspectsList(startIndex, fetchLimit);
    if (_prospectsResult is List<DemandesProspectListModel>) {
      if (isPagination) {
        prospectsResultsList += _prospectsResult;
        if (_prospectsResult.isEmpty) paginationFinish = true;
      } else {
        prospectsResultsList = _prospectsResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      prospectsToShowInListView.clear();
      for (var demande in prospectsResultsList) {
        prospectsToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_prospectsResult is int) {
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
        dataLoadingErrorMessage = _prospectsResult;
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
    isProspectsListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      await getProspectsList(
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
      DemandesProspectListModel prospect, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    DetailsModel detail =
        DetailsModel(code: prospect.codeProspect, title: prospect.nomProspect);

    print("la ba");
    print(detail.code);
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_PROSPECT_DETAILS_TAB_VIEW,
      arguments: detail,
    ).then(
      (_) async {
        prospectsToShowInListView.clear();
        dataFinishLoading = false;
        await getProspectsList(
          context: context,
          viewModel: viewModel,
        );
      },
    );
  }

  DemandeProspectDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeProspectDetailsViewArguments(
      nomProspect: prospectsToShowInListView[index].nomProspect,
      numProspect: prospectsToShowInListView[index].numProspect,
      prenomProspect: prospectsToShowInListView[index].prenomProspect,
      tel: prospectsToShowInListView[index].tel,
      titre: prospectsToShowInListView[index].titre,
      societe: prospectsToShowInListView[index].societe,
      origineProspect: prospectsToShowInListView[index].origineProspect,
      libSecteurActivite: prospectsToShowInListView[index].libSecteurActivite,
      mail: prospectsToShowInListView[index].mail,
      chiffreAffaire: prospectsToShowInListView[index].chiffreAffaire,
      portable: prospectsToShowInListView[index].portable,
      nbremp: prospectsToShowInListView[index].nbremp,
      collab: prospectsToShowInListView[index].collab,
    );
  }
}

onPressAction(DemandesProspectListViewModel viewModel, String code) async {}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeProspectDetailsViewArguments {
  final String numProspect;
  final String nomProspect;
  final String prenomProspect;

  final String tel;
  final String titre;
  final String societe;
  final String origineProspect;
  final String libSecteurActivite;
  final String mail;
  final String chiffreAffaire;
  final String portable;
  final String nbremp;
  final String collab;

  DemandeProspectDetailsViewArguments({
    required this.nomProspect,
    required this.numProspect,
    required this.prenomProspect,
    required this.tel,
    required this.titre,
    required this.societe,
    required this.origineProspect,
    required this.libSecteurActivite,
    required this.mail,
    required this.chiffreAffaire,
    required this.portable,
    required this.collab,
    required this.nbremp,
  });
}
