import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/view_states.dart';
import '../../../core/view_models/auth/login_view_model.dart';
import '../../shared/navigation_router_paths.dart';
import '../../shared/size_config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_field_password.dart';
import '../base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _domainTextFieldController;
  late TextEditingController _usernameTextFieldController;
  late TextEditingController _passwordTextFieldController;
  bool _saveMyPasswordCheckValue = false;
  bool isViewBusy = false;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    _domainTextFieldController = TextEditingController();
    _usernameTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _domainTextFieldController.dispose();
    _usernameTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (_) {
        String? domaine = Constants.domaine;
        String? username = Constants.username;
        if (domaine != null && username != null) {
          _domainTextFieldController.text = domaine;
          _usernameTextFieldController.text = username;
        }
        String? password = Constants.password;
        if (password != null) {
          _passwordTextFieldController.text = password;
          _saveMyPasswordCheckValue = true;
        }
      },
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("BigSoft"),
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
                          // TODO: Return await function
                          //await viewModel.logout();
                          setState(() {
                            isViewBusy = false;
                          });
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
          return true;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: AbsorbPointer(
              absorbing: viewModel.state == ViewState.Busy,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 6,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 6),
                      Text(
                        "Connexion",
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 6),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _domainTextFieldController,
                              maxLines: 1,
                              inputLabel: "Domaine",
                              helperText: " ",
                              validation: textFieldValidation,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            CustomTextField(
                              controller: _usernameTextFieldController,
                              maxLines: 1,
                              inputLabel: "Utilisateur",
                              helperText: " ",
                              validation: textFieldValidation,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            CustomTextFieldPassword(
                              controller: _passwordTextFieldController,
                              inputLabel: "Mot de passe",
                              validation: textFieldValidation,
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 38,
                            child: Checkbox(
                              value: _saveMyPasswordCheckValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _saveMyPasswordCheckValue = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 2),
                          GestureDetector(
                            onTap: () => setState(() {
                              _saveMyPasswordCheckValue =
                                  !_saveMyPasswordCheckValue;
                            }),
                            child: Text(
                              "Mémoriser mon mot de passe",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 3.8),
                      CustomButton(
                        buttonText: "se connecter",
                        isBusy: viewModel.state == ViewState.Busy,
                        onPressAction: () => onPressAction(
                          _scaffoldKey.currentState,
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
      ),
    );
  }

  String? textFieldValidation(String? value) {
    if (value!.isEmpty) return 'Veuillez remplir ce champ';
    // TODO: I changed the return type 'Result' from null in the validation check from null to string :: I did that same where too
    return null;
  }

  onPressAction(scaffoldState, LoginViewModel viewModel) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      // TODO: Return the await function to have the loginresult result
      var loginResult = await viewModel.login(
        domain: _domainTextFieldController.text,
        username: _usernameTextFieldController.text,
        password: _passwordTextFieldController.text,
      );
      // TODO: true added by me to remove after exec the previous await
      //var loginResult = true;
      if (loginResult is bool) {
        Constants.domaine = _domainTextFieldController.text;
        Constants.username = _usernameTextFieldController.text;
        // TODO: Return the await function to write the result in the local storage
        await viewModel.writeDomaineAndUsernameToLocalStorage(
          domaine: Constants.domaine,
          username: Constants.username,
        );
        Constants.password = _passwordTextFieldController.text;
        if (_saveMyPasswordCheckValue) {
          await viewModel.writePasswordToLocalStorage(
            password: Constants.password,
          );
          // TODO: Return the await function to write the result in the local storage
        } else {
          await viewModel.removePasswordFromLocalStorage();
          // TODO: Return the await function to remove from the local storage
        }
        // TODO: Return the push to navigate the next route

        Navigator.pushReplacementNamed(
          context,
          NavigationRouterPaths.UNITE_EXERCICE,
        );
      } else {
        // TODO: Return the showSnack to print the result error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginResult, textAlign: TextAlign.center),
          ),
        );
      }
    }
    /* Navigator.pushReplacementNamed(
      context,
      NavigationRouterPaths.UNITE_EXERCICE,
    );*/
  }
}
