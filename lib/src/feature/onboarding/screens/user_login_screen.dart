// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/core/utils/validators/form_validations.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/forgot_password.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_signup_screen.dart';
import 'package:sizzle_starter/src/home_screen.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  bool? _passwordVisible = false, _check = false;
  late ThemeData themeData;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
    themeData = Theme.of(context);
    MySize().init(context);

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              _showError(state.message);
            }
            if (state is AppAutheticated) {
              _showError('user logged in');
              context.goNamed('Home');
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) =>
                  Stack(
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
                                child: Form(
                                  key: _key,
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
                                          "USER LOGIN",
                                          style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.titleLarge,
                                              fontWeight: 600),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: _emailController,
                                              validator: validateEmail,
                                              style:
                                                  AppThemeCustom.getTextStyle(
                                                      themeData
                                                          .textTheme.bodyLarge,
                                                      letterSpacing: 0.1,
                                                      color: themeData
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                hintStyle:
                                                    AppThemeCustom.getTextStyle(
                                                        themeData.textTheme
                                                            .titleSmall,
                                                        letterSpacing: 0.1,
                                                        color: themeData
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight: 500),
                                                prefixIcon:
                                                    Icon(MdiIcons.email),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 16),
                                              child: TextFormField(
                                                controller: _passwordController,
                                                validator: validatePassword,
                                                style:
                                                    AppThemeCustom.getTextStyle(
                                                        themeData.textTheme
                                                            .bodyLarge,
                                                        letterSpacing: 0.1,
                                                        color: themeData
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight: 500),
                                                decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: AppThemeCustom
                                                      .getTextStyle(
                                                          themeData.textTheme
                                                              .titleSmall,
                                                          letterSpacing: 0.1,
                                                          color: themeData
                                                              .colorScheme
                                                              .secondary,
                                                          fontWeight: 500),
                                                  prefixIcon: Icon(
                                                      MdiIcons.lockOutline),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(_passwordVisible!
                                                        ? MdiIcons.eyeOutline
                                                        : MdiIcons
                                                            .eyeOffOutline),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                obscureText: _passwordVisible!,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: MySize.size20!),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    // Checkbox(
                                                    //   activeColor: themeData
                                                    //       .colorScheme.primary,
                                                    //   onChanged: (bool? value) {
                                                    //     setState(() {
                                                    //       _check = value;
                                                    //     });
                                                    //   },
                                                    //   value: _check,
                                                    //   visualDensity:
                                                    //       VisualDensity.compact,
                                                    // ),
                                                    // Text(
                                                    //     "I agree to the terms and conditions.",
                                                    //     style: AppThemeCustom
                                                    //         .getTextStyle(
                                                    //             themeData.textTheme
                                                    //                 .bodyMedium,
                                                    //             fontWeight: 500)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context.push(
                                                            '/forgotPassword');
                                                      },
                                                      child: Text(
                                                          " Forgot Password",
                                                          style: AppThemeCustom
                                                              .getTextStyle(
                                                                  themeData
                                                                      .textTheme
                                                                      .bodyMedium,
                                                                  fontWeight:
                                                                      600,
                                                                  color: themeData
                                                                      .colorScheme
                                                                      .primary)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 16),
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
                                                            themeData
                                                                .colorScheme
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
                                                    if (_key.currentState!
                                                        .validate()) {
                                                      authenticationBloc.add(
                                                          UserLogin(
                                                              email:
                                                                  _emailController
                                                                      .text,
                                                              password:
                                                                  _passwordController
                                                                      .text));
                                                    } else {}
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
                                                      : Text("LOGIN",
                                                          style: AppThemeCustom
                                                              .getTextStyle(
                                                                  themeData
                                                                      .textTheme
                                                                      .labelLarge,
                                                                  fontWeight:
                                                                      600,
                                                                  color: themeData
                                                                      .colorScheme
                                                                      .onPrimary,
                                                                  letterSpacing:
                                                                      0.5))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push('/signup');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "Don't have an Account? ",
                                          style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyMedium,
                                              fontWeight: 500)),
                                      TextSpan(
                                          text: " SignUp",
                                          style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyMedium,
                                              fontWeight: 600,
                                              color: themeData
                                                  .colorScheme.primary)),
                                    ]),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 12,
                        child: BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                      )
                    ],
                  ))),
    );
  }

  void _showError(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
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
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
