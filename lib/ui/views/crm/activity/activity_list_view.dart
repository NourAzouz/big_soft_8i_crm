import 'package:big_soft_8i_crm/core/models/get_details_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/core/models/demandes_Prospect_ACT_list_model.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/view_models/crm/activity/demandes_Activity_list_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<DemandesActivityListModel> activitiesResultsList;
late List<DemandesActivityListModel> activitiesToShowInListView;
var _activitiesResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late DemandesActivityListModel slectedActivitySearchResult;
bool isActivitiesListViewBusy = false;
bool isActivitiesViewBusy = false;
late GlobalKey<FormState> _formKey;

List<DemandesActivityListModel> getActivitiesListToSearchFrom() {
  return activitiesResultsList;
}

setActivityToShowInListView(var demande) {
  activitiesToShowInListView.clear();
  activitiesToShowInListView.add(demande);
}

bool isLoadingActivityDataError() {
  return dataLoadingError;
}

class ActivityListView extends StatefulWidget {
  final code_listAct;
  const ActivityListView({Key? key, this.code_listAct}) : super(key: key);

  //late GlobalKey<FormState> _formKey;
  @override
  _ActivityListViewState createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  late String code_listArt;

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<DemandesActivityListModel> activities;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    activitiesResultsList = [];
    activitiesToShowInListView = [];
    dataLoadingError = false;
    activities = activitiesToShowInListView;
    code_listArt = widget.code_listAct;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesActivityListViewModel>(
      onModelReady: (viewModel) async {
        if (code_listArt != "") {
          print('pros here with no null');
          await getActivitiesListProspect(
              viewModel: viewModel, context: context);
        } else {
          print('pros here with  null');
          await getActivities(viewModel: viewModel, context: context);
        }
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
                      "Activities",
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
                              child: activitiesResultsList.isNotEmpty
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
                                          if (code_listArt != "") {
                                            await getActivitiesListProspect(
                                                viewModel: viewModel,
                                                context: context);
                                          } else {
                                            await getActivities(
                                                viewModel: viewModel,
                                                context: context);
                                          }

                                          /* await getActivities(
                                            viewModel: viewModel,
                                            context: context,
                                            scaffoldState:
                                                _scaffoldKey.currentState,
                                          );*/
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: activities,
                                          groupBy: (element) =>
                                              element.dateDebut,
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
                                                    '${activities[index].sujet}',
                                                  ),
                                                  subtitle: Text(
                                                    ' ${activities[index].dateDebut} ',
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
                                                  trailing: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                  ),
                                                  onTap: () => {
                                                    navigateToDemandeDetailsView(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      activities[index],
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
                                                            activities.length -
                                                                1
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
                                        if (code_listArt != "") {
                                          //print('pros here with no null');
                                          await getActivitiesListProspect(
                                              viewModel: viewModel,
                                              context: context);
                                        } else {
                                          // print('pros here with  null');
                                          await getActivities(
                                              viewModel: viewModel,
                                              context: context);
                                        }
                                        /*await getActivities(
                                          viewModel: viewModel,
                                          context: context,
                                          scaffoldState:
                                              _scaffoldKey.currentState,
                                        );*/
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
                                                  "Aucune Activity enregistrée",
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
                                      if (code_listArt != "") {
                                        // print('pros here with no null');
                                        await getActivitiesListProspect(
                                            viewModel: viewModel,
                                            context: context);
                                      } else {
                                        // print('pros here with  null');
                                        await getActivities(
                                            viewModel: viewModel,
                                            context: context);
                                      }

                                      /*await getActivities(
                                        viewModel: viewModel,
                                        context: context,
                                        scaffoldState:
                                            _scaffoldKey.currentState,
                                      );*/
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
        hintText: 'Code ou  sujet activity',
        onChanged: searchActivity,
      );

  void searchActivity(String query) {
    final activities = activitiesToShowInListView.where((activity) {
      final codeActivity = activity.codeDoc.toLowerCase();
      final sujetActivity = activity.sujet.toLowerCase();
      final search = query.toLowerCase();

      return codeActivity.contains(search) || sujetActivity.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.activities = activities;
    });
  }

  Future<void> getActivities({
    required DemandesActivityListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isActivitiesListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _activitiesResult =
        await viewModel.getActivitiesList(startIndex, fetchLimit);
    if (_activitiesResult is List<DemandesActivityListModel>) {
      if (isPagination) {
        activitiesResultsList += _activitiesResult;
        if (_activitiesResult.isEmpty) paginationFinish = true;
      } else {
        activitiesResultsList = _activitiesResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      activitiesToShowInListView.clear();
      for (var demande in activitiesResultsList) {
        activitiesToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_activitiesResult is int) {
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
        dataLoadingErrorMessage = _activitiesResult;
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
    /*DemandesActivityListService _demandesListService =
        locator<DemandesActivityListService>();
    var _activitiesdetailsResult = await _demandesListService
        .getActivityDetails("947d457123464bddb36e4686304ebf2a");*/
    //print(_activitiesdetailsResult.numero);
    isActivitiesListViewBusy = false;
  }

  Future<void> getActivitiesListProspect({
    required DemandesActivityListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isActivitiesListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _activitiesResult = await viewModel.getActivitiesListProspect(code_listArt);
    if (_activitiesResult is List<DemandesActivityListModel>) {
      if (isPagination) {
        activitiesResultsList += _activitiesResult;
        if (_activitiesResult.isEmpty) paginationFinish = true;
      } else {
        activitiesResultsList = _activitiesResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      activitiesToShowInListView.clear();
      for (var demande in activitiesResultsList) {
        activitiesToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_activitiesResult is int) {
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
        dataLoadingErrorMessage = _activitiesResult;
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
    /*DemandesActivityListService _demandesListService =
        locator<DemandesActivityListService>();
    var _activitiesdetailsResult = await _demandesListService
        .getActivityDetails("947d457123464bddb36e4686304ebf2a");
    print(_activitiesdetailsResult.numero);*/
    isActivitiesListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      await getActivities(
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
      DemandesActivityListModel activity, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    DetailsModel detail =
        DetailsModel(code: activity.numero, title: activity.sujet);
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_ACTIVITY_DETAILS_TAB_VIEW,
      arguments: detail,
    ).then(
      (_) async {
        activitiesToShowInListView.clear();
        dataFinishLoading = false;
        await getActivities(
          context: context,
          viewModel: viewModel,
        );
      },
    );
  }

  DemandeActivityDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeActivityDetailsViewArguments(
      sujet: activitiesToShowInListView[index].sujet,
      dateDebut: activitiesToShowInListView[index].dateDebut,
      lieu: activitiesToShowInListView[index].lieu,
      heureDebut: activitiesToShowInListView[index].heureDebut,
      statut: activitiesToShowInListView[index].statut,
      typedoc: activitiesToShowInListView[index].typedoc,
      codeDoc: activitiesToShowInListView[index].codeDoc,
      desc: activitiesToShowInListView[index].description,
      contact: activitiesToShowInListView[index].nomContact,

      //prenomActivity: demandesToShowInListView[index].prenomActivity,
    );
  }
}

onPressAction(DemandesActivityListViewModel viewModel, String code) async {}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeActivityDetailsViewArguments {
  final String dateDebut;
  final String sujet;
  final String heureDebut;
  final String lieu;
  final String statut;
  final String typedoc;
  final String codeDoc;
  final String desc;
  final String contact;
  DemandeActivityDetailsViewArguments({
    required this.sujet,
    required this.dateDebut,
    required this.heureDebut,
    required this.lieu,
    required this.statut,
    required this.typedoc,
    required this.codeDoc,
    required this.desc,
    required this.contact,
  });
}
