import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/view_states.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/auth/ip_address_setup_view_model.dart';
import '../../../locator.dart';
import '../../shared/navigation_router_paths.dart';
import '../../shared/size_config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../base_view.dart';

class IpAddressSetupView extends StatefulWidget {
  @override
  _IpAddressSetupViewState createState() => _IpAddressSetupViewState();
}

class _IpAddressSetupViewState extends State<IpAddressSetupView> {
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _ipAddressTextFieldController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    _ipAddressTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _ipAddressTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<IpAddressSetupViewModel>(
      onModelReady: (viewModel) {
        String? ipAddress = Constants.ipAddress;
        if (ipAddress != null) {
          print("here ip adress!null");
          _ipAddressTextFieldController.text = ipAddress;
        }
      },
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: AbsorbPointer(
            absorbing: viewModel.state == ViewState.Busy,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                SizeConfig.widthMultiplier * 6,
                SizeConfig.heightMultiplier * 4.8,
                SizeConfig.widthMultiplier * 6,
                0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Veuillez saisir le DNS ou l'adresse IP de votre serveur web",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        fontSize: SizeConfig.textMultiplier * 5.5,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    Image.asset(
                      "assets/images/Server-rafiki.png",
                      height: SizeConfig.imageSizeMultiplier * 40,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    Form(
                      key: _formKey,
                      child: CustomTextField(
                        controller: _ipAddressTextFieldController,
                        maxLines: 1,
                        inputLabel: "DNS ou adresse IP",
                        helperText: " ",
                        validation: textFieldValidation,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    CustomButton(
                      buttonText: "suivant",
                      isBusy: viewModel.state == ViewState.Busy,
                      onPressAction: () => onPressAction(
                        context,
                        _scaffoldKey.currentState!,
                        viewModel,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? textFieldValidation(String? value) {
    if (value!.isEmpty) return 'Veuillez remplir ce champ';
    return null;
  }

  onPressAction(
    context,
    ScaffoldState scaffoldState,
    IpAddressSetupViewModel viewModel,
  ) async {
    if (_formKey.currentState!.validate()) {
      if (_ipAddressTextFieldController.text ==
          "www.biginformatique.com:8080/BigSoftWeb") {
        Constants.ipAddress = "8i.biginformatique.com";
        Constants.baseURL = "https://${Constants.ipAddress}";
        Constants.appName = "";
      } else if (_ipAddressTextFieldController.text ==
          "8i.biginformatique.com") {
        Constants.ipAddress = "8i.biginformatique.com";
        Constants.baseURL = "https://${Constants.ipAddress}";
        Constants.appName = "";
      } else if (_ipAddressTextFieldController.text.contains('.ovh')) {
        Constants.ipAddress = _ipAddressTextFieldController.text;
        Constants.baseURL = "https://${Constants.ipAddress}";
        Constants.appName = "";
      } else {
        print(_ipAddressTextFieldController.text);
        Constants.ipAddress = _ipAddressTextFieldController.text;
        print(Constants.ipAddress);
        Constants.baseURL = "http://${Constants.ipAddress}";
        //Constants.baseURL = "http://hi";
        Constants.appName = "BigSoftWeb/";
      }
      // TODO: Return the await to result function
      var sessionResult = await viewModel.getSessionIdFromHomePage();
      // var sessionResult ='V';
      if (sessionResult.startsWith("C") ||
          /*sessionResult.startsWith("V") ||*/
          sessionResult.startsWith("U")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(sessionResult, textAlign: TextAlign.center),
          ),
        );
      } else if (sessionResult.startsWith("V")) {
        // TODO: Return the await to result function
        bool isValidateSessionResult =
            await _localStorageService.isValidateSessionResult();
        //bool isValidateSessionResult = true;
        if (isValidateSessionResult) {
          // TODO: Return the push function to go to the next route
          Navigator.pushReplacementNamed(
              context, NavigationRouterPaths.OFFLINE);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sessionResult, textAlign: TextAlign.center),
            ),
          );
        }
      } else {
        Constants.sessionId = sessionResult;
        // TODO: Return the code in comments
        viewModel.writeIpAddressToLocalStorage(
          _ipAddressTextFieldController.text,
        );
        Navigator.pushReplacementNamed(context, NavigationRouterPaths.LOGIN);
      }
    }
    //Navigator.pushReplacementNamed(context, NavigationRouterPaths.LOGIN);
  }
}
