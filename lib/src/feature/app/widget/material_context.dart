
import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/choose_login.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/forgot_password.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/lawyer_login_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/reset_password_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_login_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_signup_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/verify_email_screen.dart';
import 'package:sizzle_starter/src/feature/settings/widget/settings_scope.dart';
import 'package:get/get.dart';
import 'package:sizzle_starter/src/splash_screen.dart';
/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});
  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
     final theme = SettingsScope.themeOf(context).theme;
     final themeData = theme.computeTheme();
    return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          themeMode: ThemeMode.light,
          home: ResetPasswordScreen(),
          // builder: (context, child) => MediaQuery.withClampedTextScaling(
          //   key: _globalKey,
          //   minScaleFactor: 1.0,
          //   maxScaleFactor: 2.0,
          //   child: child!,
          // ),
        );
  }
}


