import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/application_icon.dart';
import '/ui/widgets/custom_flutter_toast.dart';
import '/ui/widgets/drawer_item.dart';
import '/ui/widgets/drawer_item_with_background.dart';
import '/ui/widgets/drawer_section_header.dart';

bool isViewBusy = false;

class DrawerChildren extends StatefulWidget {
  final viewModel;
  final buildContext;
  final scaffoldState;
  final isHomeViewSelected;
  final VoidCallback? homeViewTapAction;

  const DrawerChildren({
    Key? key,
    required this.viewModel,
    required this.buildContext,
    required this.scaffoldState,
    this.isHomeViewSelected,
    this.homeViewTapAction,
  }) : super(key: key);

  @override
  _DrawerChildrenState createState() => _DrawerChildrenState();
}

class _DrawerChildrenState extends State<DrawerChildren> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DrawerItemWithBackground(
            itemLabel: "Accueil",
            icon: Icons.home,
            isSelectedItem: widget.isHomeViewSelected,
            onTapAction: widget.homeViewTapAction,
          ),
          const Divider(),
          const DrawerSectionHeader(sectionLabel: "Compte"),
          DrawerItem(
              itemLabel: "Déconnexion",
              icon: Icons.power_settings_new,
              onTapAction: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Big Soft"),
                        content: const Text(
                            "Voulez-vous vraiment vous déconnecter?"),
                        actions: [
                          AbsorbPointer(
                            absorbing: isViewBusy,
                            child: TextButton(
                              child: const Text("Annuler"),
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(),
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
                                print('logout there');
                                var logoutResult =
                                    await widget.viewModel.logout();
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
                        elevation: 24.0,
                      );
                    },
                  ),
                );
              }),
          const Divider(),
          const DrawerSectionHeader(sectionLabel: "Aide"),
          DrawerItem(
            itemLabel: "Contactez le support",
            icon: Icons.help,
            onTapAction: () => contactezLeSupportAction(widget.buildContext),
          ),
          DrawerItem(
            itemLabel: "A propos",
            icon: Icons.info,
            onTapAction: () => aProposAction(widget.buildContext),
          ),
        ],
      ),
    );
  }

  deconnexionAction(context, scaffoldState, viewModel) {
    Navigator.of(context).pop();
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
                    var logoutResult = await widget.viewModel.logout();
                    if (logoutResult is bool) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        NavigationRouterPaths.STARTUP_LOGIC,
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      scaffoldState.showSnackBar(
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

  contactezLeSupportAction(context) {
    Navigator.of(context).pop();
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

  aProposAction(context) {
    Navigator.of(context).pop();
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
}
