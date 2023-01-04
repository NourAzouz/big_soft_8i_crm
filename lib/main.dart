// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'ui/navigation_router.dart';
import 'ui/shared/size_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/constants.dart';
import 'core/services/local_storage_service.dart';
import 'locator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //runApp(App());
  await FlutterDownloader.initialize(
    debug: true,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(App()),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: const [Locale('fr')],
              debugShowCheckedModeBanner: false,
              title: 'BigSoft 8i crm',
              theme: ThemeData(
                //scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.purple,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: "Cairo",
                scaffoldBackgroundColor: kBackgroundColor,
                textTheme:
                    Theme.of(context).textTheme.apply(displayColor: kTextColor),
              ),
              initialRoute: initialRoute,
              onGenerateRoute: NavigationRouter.generateRoute,
              navigatorKey: navigatorKey,
            );
          },
        );
      },
    );
  }
}

//  void getCollab(DemandeListDetailsViewModel viewModel) async {
//     // TODO: Return the call of await function to get right result & remove the static one
//     var _uniteResult = await viewModel.getCollab(0,25);

//     // var _uniteResult =<UniteModel>[];
//     if (_uniteResult is List<DemandesCollabListModel>) {
//        demandesResultsList = _uniteResult;
      
//       // TODO: Return the call of await function & remove the static one
     
      
//     } else if (_uniteResult is int) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) => WillPopScope(
//           onWillPop: () async => false,
//           child: const ContactSupportAlertView(),
//         ),
//       );
//     } else {
//       setState(() {
      
//         dataLoadingError = true;
//       });
//     }
//     setState(() {
//       dataFinishLoading = true;
//     });
//   }