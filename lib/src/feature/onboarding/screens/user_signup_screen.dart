// ignore_for_file: unnecessary_raw_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/core/utils/validators/form_validations.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/initialization/model/dependencies.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  late ThemeData themeData;
  late AuthenticationBloc authenticationBloc;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
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

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
    MySize().init(context);
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          _showError(state.message);
        }
       if(state is AppAutheticated){
         _showError('user signed in');
       }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) => Stack(
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
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: MySize.size16!,
                              bottom: MySize.size16!,
                            ),
                            child: Form(
                              key: _key,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: MySize.size8!),
                                    child: Text(
                                      "REGISTER",
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
                                            style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: 500,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Full Name",
                                              hintStyle:
                                                  AppThemeCustom.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                color: themeData
                                                    .colorScheme.secondary,
                                                fontWeight: 500,
                                              ),
                                              prefixIcon:
                                                  Icon(MdiIcons.accountOutline),
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MySize.size16!),
                                          child: TextFormField(
                                            style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: 500,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle:
                                                  AppThemeCustom.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                color: themeData
                                                    .colorScheme.secondary,
                                                fontWeight: 500,
                                              ),
                                              prefixIcon:
                                                  Icon(MdiIcons.phoneOutline),
                                            ),
                                            keyboardType: TextInputType.number,
                                            validator: validateEmail,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MySize.size16!),
                                          child: TextFormField(
                                            style: AppThemeCustom.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: 500,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Password",
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
                                            obscureText: _passwordVisible,
                                            validator: validatePassword,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MySize.size24!),
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
                                                  WidgetStateProperty.all(
                                                themeData.colorScheme.primary,
                                              ),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      MySize
                                                          .getScaledSizeHeight(
                                                        8,
                                                      ),
                                                    ),
                                                  ), // Square corners
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (_key.currentState!
                                                  .validate()) {
                                                authenticationBloc.add(
                                                    UserLogin(
                                                        email: _emailController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text));
                                              } else {}
                                            },
                                            child:
                                                state is AuthenticationLoading
                                                    ? CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .color,
                                                      )
                                                    : Text(
                                                        "REGISTER",
                                                        style: AppThemeCustom
                                                            .getTextStyle(
                                                          themeData.textTheme
                                                              .labelLarge,
                                                          fontWeight: 600,
                                                          color: themeData
                                                              .colorScheme
                                                              .onPrimary,
                                                        ),
                                                      ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: MySize.size16!,
                              bottom: MySize.size8!,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Already Have an Account? ",
                                    style: AppThemeCustom.getTextStyle(
                                      themeData.textTheme.bodyMedium,
                                      fontWeight: 500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Login",
                                    style: AppThemeCustom.getTextStyle(
                                      themeData.textTheme.bodyMedium,
                                      fontWeight: 600,
                                      color: themeData.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
              )),
    ));
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
