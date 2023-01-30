// ignore_for_file: unnecessary_string_escapes

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/view_models/home_view_model.dart';
import '../views/base_view.dart';
import '../views/details_screen.dart';
import '../widgets/category_card.dart';

import '../shared/navigation_router_paths.dart';

bool isHomeViewBusy = false;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and width of our device
    return BaseView<HomeViewModel>(
        onModelReady: (viewModel) async {
          await startFeatureDiscovery(viewModel);
        },
        builder: (context, viewModel, child) => Scaffold(
            key: _scaffoldKey,
            body: Stack(children: <Widget>[
              SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.centerRight,
                                  image:
                                      AssetImage("assets/images/welcome.png")),
                              color: Colors.white,
                              border: Border.all(width: 7, color: Colors.blue),
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width * 0.84,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                child: Column(children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Row(children: [
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "BigSoft CRM",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Open Sans',
                                      fontSize: 25),
                                ),
                              ])
                            ])),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRouterPaths.Demande_list,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 7, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30)),
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center //Center Column contents vertically,
                                  ,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.blue,
                                          size: 60.0,
                                          semanticLabel: 'Gerer Vos Clients',
                                        ),
                                        Text(
                                          "Contacts ",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.blue),
                                        ),
                                      ],
                                    ))
                                  ]),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRouterPaths.Demandes_Prospect_list,
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 7,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.42,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center //Center Column contents vertically,
                                          ,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.monetization_on_rounded,
                                              color: Colors.blue,
                                              size: 50.0,
                                              semanticLabel:
                                                  'Gerer Vos Clients',
                                            ),
                                            Text(
                                              "Prospect",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ]),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRouterPaths.Demandes_Compte_list,
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 7,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.42,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center //Center Column contents vertically,
                                          ,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.account_circle_rounded,
                                              color: Colors.blue,
                                              size: 50.0,
                                              semanticLabel:
                                                  'Gerer Vos Clients',
                                            ),
                                            Text(
                                              "Comptes",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ]),
                                ))),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  NavigationRouterPaths.Demandes_Product_list,
                                  arguments: "");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 7,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.42,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center //Center Column contents vertically,
                                          ,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Icon(
                                              Icons.shopping_cart_rounded,
                                              color: Colors.blue,
                                              size: 50.0,
                                              semanticLabel:
                                                  'Gerer Vos Clients',
                                            ),
                                            Text(
                                              "Produits",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ]),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRouterPaths.Demandes_Affaire_list,
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 7,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.42,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center //Center Column contents vertically,
                                          ,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.bar_chart_rounded,
                                              color: Colors.blue,
                                              size: 50.0,
                                              semanticLabel:
                                                  'Gerer Vos Clients',
                                            ),
                                            Text(
                                              "Affaires",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ]),
                                ))),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  NavigationRouterPaths.Demandes_Activity_list,
                                  arguments: "");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 7,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.42,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center //Center Column contents vertically,
                                      ,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center //Center Column contents vertically,
                                          ,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.task,
                                              color: Colors.blue,
                                              size: 50.0,
                                              semanticLabel:
                                                  'Gerer Vos Clients',
                                            ),
                                            Text(
                                              "Activité",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ]),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
            ])));
  }

  Future<void> startFeatureDiscovery(HomeViewModel viewModel) async {
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
}
