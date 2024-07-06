// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/core/utils/validators/form_validations.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String resetpasswordtoken;

  const ResetPasswordScreen({Key? key, required this.resetpasswordtoken})
      : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  late ThemeData themeData;
  late AuthenticationBloc authenticationBloc;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
    MySize().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is PasswordResetSuccessful) {
              _showError('password reset successfully');
              Get.offAll(UserLoginScreen());
            } else if (state is AuthenticationFailure) {
              _showError(state.message);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) => Stack(
              children: <Widget>[
                ClipPath(
                  clipper: _MyCustomClipper(context),
                  child: Container(
                    alignment: Alignment.center,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                Positioned(
                  left: MySize.size30,
                  right: MySize.size30,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: MySize.size16!,
                              bottom: MySize.size16!,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: MySize.size8!),
                                  child: Text(
                                    "RESET PASSWORD",
                                    style: AppThemeCustom.getTextStyle(
                                      themeData.textTheme.titleLarge,
                                      fontWeight: 600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MySize.size16!,
                                    right: MySize.size16!,
                                    top: MySize.size8!,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MySize.size16!),
                                        child: TextFormField(
                                          validator: validatePassword,
                                          controller: _passwordController,
                                          style: AppThemeCustom.getTextStyle(
                                            themeData.textTheme.bodyLarge,
                                            color:
                                                themeData.colorScheme.secondary,
                                            fontWeight: 500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "New Password",
                                            hintStyle:
                                                AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                              color: themeData
                                                  .colorScheme.secondary,
                                              fontWeight: 500,
                                            ),
                                            prefixIcon:
                                                Icon(MdiIcons.lockOutline),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible
                                                    ? MdiIcons.eyeOutline
                                                    : MdiIcons.eyeOffOutline,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText: !_passwordVisible,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MySize.size24!),
                                        child: TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          style: AppThemeCustom.getTextStyle(
                                            themeData.textTheme.bodyLarge,
                                            color:
                                                themeData.colorScheme.secondary,
                                            fontWeight: 500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "Confirm New Password",
                                            hintStyle:
                                                AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                              color: themeData
                                                  .colorScheme.secondary,
                                              fontWeight: 500,
                                            ),
                                            prefixIcon:
                                                Icon(MdiIcons.lockOutline),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _confirmPasswordVisible
                                                    ? MdiIcons.eyeOutline
                                                    : MdiIcons.eyeOffOutline,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _confirmPasswordVisible =
                                                      !_confirmPasswordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText: !_confirmPasswordVisible,
                                          validator: (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MySize.size30!),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(MySize.size24!),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: themeData
                                                  .colorScheme.primary
                                                  .withAlpha(28),
                                              blurRadius: 3,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                              themeData.colorScheme.primary,
                                            ),
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(MySize
                                                      .getScaledSizeHeight(8)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              authenticationBloc.add(
                                                ResetPassword(
                                                  token:
                                                      widget.resetpasswordtoken,
                                                  newPassword:
                                                      _passwordController.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: state is AuthenticationLoading
                                              ? CircularProgressIndicator(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .color,
                                                )
                                              : Text(
                                                  "Change Password",
                                                  style: AppThemeCustom
                                                      .getTextStyle(
                                                    themeData
                                                        .textTheme.labelLarge,
                                                    fontWeight: 600,
                                                    color: themeData
                                                        .colorScheme.onPrimary,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MySize.size24!,
                  left: MySize.size12!,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
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
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
