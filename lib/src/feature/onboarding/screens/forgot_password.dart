// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late AuthenticationBloc authenticationBloc;
  late ThemeData themeData;
  late TextEditingController controllermobile;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controllermobile = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controllermobile.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    MySize().init(context);
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is ForgotPasswordSent) {
            _showResetEmailSentDialog();
          } else if (state is AuthenticationFailure) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) =>
                Scaffold(
                    body: Stack(
                  children: <Widget>[
                    ClipPath(
                        clipper: _MyCustomClipper(context),
                        child: Container(
                          alignment: Alignment.center,
                          color: themeData.colorScheme.primary,
                        )),
                    Positioned(
                      left: 30,
                      right: 30,
                      top: MediaQuery.of(context).size.height * 0.15,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Card(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Column(
                                children: <Widget>[
                                  Image(
                                    image: const AssetImage(
                                        'assets/images/logo-removebg-preview.png'),
                                    height: MySize.size180,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 24, top: 0),
                                    child: Text(
                                      "FORGOT PASSWORD",
                                      style: AppThemeCustom.getTextStyle(
                                          themeData.textTheme.titleLarge,
                                          fontWeight: 600),
                                    ),
                                  ),
                                  const Text(
                                    "We are sending a link to your email to be able to set new password",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 20),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: controllermobile,
                                            style: AppThemeCustom.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                letterSpacing: 0.1,
                                                color: themeData
                                                    .colorScheme.secondary,
                                                fontWeight: 500),
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle:
                                                  AppThemeCustom.getTextStyle(
                                                      themeData
                                                          .textTheme.titleSmall,
                                                      letterSpacing: 0.1,
                                                      color: themeData
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight: 500),
                                              prefixIcon: Icon(MdiIcons.email),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(24)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: themeData
                                                      .colorScheme.primary
                                                      .withAlpha(18),
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          themeData.colorScheme
                                                              .primary),
                                                  shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(MySize
                                                              .getScaledSizeHeight(
                                                                  8))), // Square corners
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    authenticationBloc.add(
                                                        ForgotPassword(
                                                            email:
                                                                controllermobile
                                                                    .text));
                                                  }
                                                },
                                                child: state
                                                        is AuthenticationLoading
                                                    ? CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .color,
                                                      )
                                                    : Text("SEND LINK",
                                                        style: AppThemeCustom
                                                            .getTextStyle(
                                                                themeData
                                                                    .textTheme
                                                                    .labelLarge,
                                                                fontWeight: 600,
                                                                color: themeData
                                                                    .colorScheme
                                                                    .onPrimary,
                                                                letterSpacing:
                                                                    0.5))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 24,
                      left: 12,
                      child: BackButton(
                        onPressed: () {
                          context.pop();
                        },
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  void _showError(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _showResetEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Check Your Email"),
        content: const Text("Password reset email sent successfully."),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
