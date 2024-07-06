
import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/core/navigation/app_navigation.dart';
import 'package:sizzle_starter/src/feature/settings/widget/settings_scope.dart';
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
    return  MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          themeMode: ThemeMode.light,
          routerConfig: AppNavigation.router,
        );
  }
}


