import 'package:flutter/material.dart';
import '../../core/view_models/startup_logic_view_model.dart';
import '../shared/navigation_router_paths.dart';
import '../views/base_view.dart';

class StartupLogicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupLogicViewModel>(
      onModelReady: (viewModel) => Future.delayed(Duration.zero, () {
        //your code goes here
        checkStartupLogic(context, viewModel);
      }),
      builder: (context, viewModel, child) => const Scaffold(
        backgroundColor: Color.fromARGB(255, 194, 33, 243),
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkStartupLogic(
      context, StartupLogicViewModel viewModel) async {
    // TODO: Uncomment the two line & remove the true affectation
    await viewModel.readConstantsFromLocalStorage();
    bool _isIntroViewAlreadySeen = await viewModel.isIntroViewAlreadySeen();
    //bool _isIntroViewAlreadySeen = false;
    _isIntroViewAlreadySeen
        ? Navigator.pushReplacementNamed(
            context,
            NavigationRouterPaths.IP_ADDRESS_SETUP,
          )
        : Navigator.pushReplacementNamed(
            context,
            NavigationRouterPaths.INTRO,
          );

    /*Navigator.pushReplacementNamed(
      context,
      NavigationRouterPaths.INTRO,
    );*/
  }
}
