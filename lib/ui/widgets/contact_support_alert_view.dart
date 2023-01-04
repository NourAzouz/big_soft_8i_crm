import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/core/view_models/contact_support_alert_view_model.dart';
import '../shared/navigation_router_paths.dart';
import '../shared/size_config.dart';
import '../views/base_view.dart';
import 'custom_flutter_toast.dart';

class ContactSupportAlertView extends StatefulWidget {
  const ContactSupportAlertView({
    Key? key,
  }) : super(key: key);
  @override
  _ContactSupportAlertViewState createState() =>
      _ContactSupportAlertViewState();
}

class _ContactSupportAlertViewState extends State<ContactSupportAlertView> {
  late FToast fToast;
  bool isViewBusy = false;

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
    return BaseView<ContactSupportAlertViewModel>(
      builder: (context, viewModel, child) => AlertDialog(
        title: const Text(
          "Big Soft",
        ),
        actions: [
          SizedBox(
            width: SizeConfig.widthMultiplier * 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  child: AbsorbPointer(
                    absorbing: isViewBusy,
                    child: TextButton(
                      child: const Text(
                        "Connectez-vous à nouveau",
                        style: TextStyle(color: Colors.purple),
                      ),
                      onPressed: () async {
                        setState(() {
                          isViewBusy = true;
                        }); // TODO: Return funtions
                        var logoutResult = await viewModel.logout();
                        if (logoutResult is bool) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            NavigationRouterPaths.STARTUP_LOGIC,
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          print('here');
                          showToast(fToast, logoutResult, context);
                        }
                        setState(() {
                          isViewBusy = false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        elevation: 24.0,
        content: Container(
          height: SizeConfig.heightMultiplier * 40,
          width: SizeConfig.widthMultiplier * 80,
          child: ListView(
            children: [
              const Text(
                "une erreur est survenu lors du chargement des données contactez votre administrateur.",
              ),
              Image.asset(
                "assets/images/questions.png",
                height: SizeConfig.imageSizeMultiplier * 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
