
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/authentication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:sizzle_starter/src/feature/settings/widget/settings_scope.dart';
import 'package:get/get.dart';

import '../../authentication/presentation/screens/init_screen.dart';

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
    return ResponsiveSizer(
        builder: (context, orientation, screenType) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: const InitScreen(),
          builder: (context, child) => MediaQuery.withClampedTextScaling(
            key: _globalKey,
            minScaleFactor: 1.0,
            maxScaleFactor: 2.0,
            child: child!,
          ),
        ),
      );
  }
}

