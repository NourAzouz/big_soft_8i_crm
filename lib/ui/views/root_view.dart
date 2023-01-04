import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/constants/constants.dart';
import '../../core/view_models/root_view_model.dart';
import '../shared/navigation_router_paths.dart';
import '../shared/size_config.dart';
import '../views/base_view.dart';
import '../views/home_view.dart';
import '../widgets/application_icon.dart';
import '../widgets/custom_flutter_toast.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late FToast fToast;

  static const HOME_VIEW = 0;
  int _selectedDrawerIndex = HOME_VIEW;
  bool isViewBusy = false;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appTitle;
    switch (_selectedDrawerIndex) {
      case HOME_VIEW:
        appTitle = "Bonjour \n${Constants.username}";
        break;
      default:
        return const Center(
          child: Text("No view is defined for this drawer item"),
        );
        break;
    }
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and width of our device

    return BaseView<RootViewModel>(
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Big Soft"),
                  content: const Text("Voulez-vous quitter l'application?"),
                  actions: <Widget>[
                    AbsorbPointer(
                      absorbing: isViewBusy,
                      child: TextButton(
                        child: const Text('Annuler'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: isViewBusy,
                      child: TextButton(
                        child: const Text('Confirmer'),
                        onPressed: () async {
                          setState(() {
                            isViewBusy = true;
                          });
                          var logoutResult = await viewModel.logout();
                          if (logoutResult is bool) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              NavigationRouterPaths.STARTUP_LOGIC,
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            showToast(fToast, logoutResult, context);
                          }
                          setState(() {
                            isViewBusy = false;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          /*  bottomNavigationBar: const BottomNavBar(), */
          /* bottomNavigationBar: CurvedNavigationBar(
            index: 3,
            color:  Colors.blue[300]!,
            backgroundColor: Colors.white,
            items: const <Widget>[
              Icon(Icons.add, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
              Icon(Icons.compare_arrows, size: 30),
            ],
            onTap: (index) {
              //Handle button tap
            },
          ),*/
          body: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 28% of our total height
                height: size.height * .23,
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      SizedBox(height: SizeConfig.heightMultiplier * 4),
                      Row(
                        children: [
                          Text(
                            "Bonjour, \n${Constants.username}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 35),
                          Align(
                            alignment: Alignment.topRight,
                            child: SpeedDial(
                              animatedIcon: AnimatedIcons.menu_home,
                              direction: SpeedDialDirection.down,
                              children: [
                                SpeedDialChild(
                                    child: const Icon(
                                      Icons.power_settings_new,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.purple,
                                    label: 'Déconnexion ',
                                    labelStyle: const TextStyle(fontSize: 18.0),
                                    onTap: () => deconnexionAction(context,
                                        _scaffoldKey.currentState!, viewModel)),
                                SpeedDialChild(
                                    child: const Icon(
                                      Icons.help,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.purple,
                                    label: 'Contactez le support',
                                    labelStyle: const TextStyle(fontSize: 18.0),
                                    onTap: () =>
                                        contactezLeSupportAction(context)),
                                SpeedDialChild(
                                  child: const Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.purple,
                                  label: 'A propos',
                                  labelStyle: const TextStyle(fontSize: 18.0),
                                  onTap: () => aProposAction(context),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*Align(
                        alignment: Alignment.topRight,
                        child: SpeedDial(
                          animatedIcon: AnimatedIcons.menu_home,
                          direction: SpeedDialDirection.down,
                          children: [
                            SpeedDialChild(
                                child: const Icon(Icons.power_settings_new),
                                backgroundColor: Colors.red,
                                label: 'Déconnexion ',
                                labelStyle: const TextStyle(fontSize: 18.0),
                                onTap: () => deconnexionAction(context,
                                    _scaffoldKey.currentState!, viewModel)),
                            SpeedDialChild(
                                child: const Icon(Icons.help),
                                backgroundColor: Colors.blue,
                                label: 'Contactez le support',
                                labelStyle: const TextStyle(fontSize: 18.0),
                                onTap: () => contactezLeSupportAction(context)),
                            SpeedDialChild(
                              child: const Icon(Icons.info),
                              backgroundColor: Colors.green,
                              label: 'A propos',
                              labelStyle: const TextStyle(fontSize: 18.0),
                              onTap: () => aProposAction(context),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Bonjour, \n${Constants.username}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),*/
                      //const SearchBar(),
                      SizedBox(height: SizeConfig.heightMultiplier * 7),
                      Expanded(
                        child: _getDrawerItemView(_selectedDrawerIndex),
                        flex: 2,
                      ),
                      //SizedBox(height: SizeConfig.heightMultiplier *3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deconnexionAction(BuildContext context, ScaffoldState scaffoldState,
      RootViewModel viewModel) {
    //Navigator.of(context).pop();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          bool isViewBusy = false;
          return AlertDialog(
            title: const Text("Big Soft"),
            content: const Text("Voulez-vous vraiment vous déconnecter?"),
            actions: [
              AbsorbPointer(
                absorbing: isViewBusy,
                child: TextButton(
                  child: const Text("Annuler"),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
              ),
              AbsorbPointer(
                absorbing: isViewBusy,
                child: TextButton(
                  child: const Text("Confirmer"),
                  onPressed: () async {
                    setState(() {
                      isViewBusy = true;
                    });
                    print('logout here');
                    var logoutResult = await viewModel.logout();
                    if (logoutResult is bool) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        NavigationRouterPaths.STARTUP_LOGIC,
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(logoutResult, textAlign: TextAlign.center),
                        ),
                      );
                    }
                    setState(() {
                      isViewBusy = false;
                    });
                  },
                ),
              ),
            ],
            elevation: 24.0,
          );
        },
      ),
    );
  }

  contactezLeSupportAction(BuildContext context) {
    //Navigator.of(context).pop();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Support Technique",
          ),
          actions: [
            TextButton(
              child: Text("Fermer"),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ],
          elevation: 24.0,
          content: Container(
            height: SizeConfig.heightMultiplier * 40,
            width: SizeConfig.widthMultiplier * 80,
            child: ListView(
              children: const [
                ListTile(
                  title: Text("BIG Annaba"),
                  subtitle: Text("Tél : 213(0)38 86 18 57/86 29 94"),
                ),
                ListTile(
                  title: Text("BIG DG"),
                  subtitle: Text("Tél : 213(0)38 86 18 57/86 29 94"),
                ),
                ListTile(
                  title: Text("BIG SOFT"),
                  subtitle: Text("Tél :+ 213(0)38 55 62 99"),
                ),
                ListTile(
                  title: Text("BIG Alger"),
                  subtitle: Text(
                      "Tél :+ 213(0)21 56 19 11/19 26/19 27\n Fax :+ 213 (0) 21 56 18 97"),
                ),
                ListTile(
                  title: Text("BIG Oran"),
                  subtitle: Text(
                      "Tél :+ 213(0)41 42 77 19\n Fax :+ 213(0)41 42 77 19"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  aProposAction(BuildContext context) {
    //Navigator.of(context).pop();
    showAboutDialog(
      context: context,
      applicationVersion: 'Version 1.0.0',
      applicationIcon: ApplicationIcon(),
      applicationLegalese:
          'Cette application est conçue principalement pour les client de BIG Informatique.',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("\u00a92021 BIG Informatique \n Tous droits réservés."),
        ),
      ],
    );
  }

  _onSelectItem(int index) {
    if (!isHomeViewBusy) {
      Navigator.of(context).pop();
      setState(() {
        _selectedDrawerIndex = index;
      });
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Ancienne opération n'est pas encore terminée Veuillez patienter SVP",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  _getDrawerItemView(int position) {
    switch (position) {
      case HOME_VIEW:
        return const HomeView();
        break;
      default:
        return const Center(
          child: Text("No view is defined for this drawer item"),
        );
        break;
    }
  }
}
