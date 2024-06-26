import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}
@immutable
final class AppTheme with Diagnosticable {
  /// {@macro app_theme}
  AppTheme({required this.mode})
      :  lightTheme = AppThemeCustom.lightTheme,
        darkTheme = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xff840013),
      primaryContainer: Color(0xff00325b),
      secondary: Color(0xffffb59d),
      secondaryContainer: Color(0xff872100),
      tertiary: Color(0xff86d2e1),
      tertiaryContainer: Color(0xff004e59),
      appBarColor: Color(0xff872100),
      error: Color(0xffcf6679),
    ),
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 2.0,
    darkIsTrueBlack: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorBackgroundAlpha: 43,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabUseShape: true,
      fabAlwaysCircular: true,
      fabSchemeColor: SchemeColor.primary,
      chipSchemeColor: SchemeColor.surface,
      chipSelectedSchemeColor: SchemeColor.primaryContainer,
      popupMenuRadius: 6.0,
      popupMenuElevation: 4.0,
      alignedDropdown: true,
      dialogElevation: 3.0,
      dialogRadius: 20.0,
      useInputDecoratorThemeInDialogs: true,
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomSheetRadius: 20.0,
      bottomSheetElevation: 2.0,
      bottomSheetModalElevation: 3.0,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.onPrimary,
      menuRadius: 6.0,
      menuElevation: 4.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.background,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarIndicatorOpacity: 1.00,
      navigationBarBackgroundSchemeColor: SchemeColor.background,
      navigationBarElevation: 1.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.background,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
    ),
    keyColors: const FlexKeyColors(
      keepPrimary: true,
    ),
    tones: FlexTones.jolly(Brightness.dark).onSurfacesUseBW().surfacesUseBW(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
// To use the Playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
  );


  /// The type of theme to use.
  final ThemeMode mode;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  /// The default [AppTheme].
  static final defaultTheme = AppTheme(
    mode: ThemeMode.light,
  );

  /// The [ThemeData] for this [AppTheme].
  /// This is computed based on the [mode].
  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ThemeMode>('type', mode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppTheme && mode == other.mode;

  @override
  int get hashCode => mode.hashCode;
}



class AppThemeCustom {
  static CustomAppTheme getCustomAppTheme() {
    return CustomAppTheme.lightCustomAppTheme;
  }

  static FontWeight _getFontWeight(int weight) {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w300;
      case 500:
        return FontWeight.w400;
      case 600:
        return FontWeight.w500;
      case 700:
        return FontWeight.w600;
      case 800:
        return FontWeight.w700;
      case 900:
        return FontWeight.w900;
    }
    return FontWeight.w400;
  }

  static TextStyle getTextStyle(TextStyle? textStyle,
      {int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize = fontSize != null ? fontSize : textStyle!.fontSize;

    Color? finalColor;
    if (color == null) {
      finalColor = xMuted
          ? textStyle!.color!.withAlpha(160)
          : (muted ? textStyle!.color!.withAlpha(200) : textStyle!.color);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return GoogleFonts.ibmPlexSans(
        fontSize: finalFontSize,
        fontWeight: _getFontWeight(fontWeight),
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  //App Bar Text
  static final TextTheme lightAppBarTextTheme = TextTheme(
    displayLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 102, color: Color(0xff495057))),
    displayMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 64, color: Color(0xff495057))),
    displaySmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 51, color: Color(0xff495057))),
    headlineMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 36, color: Color(0xff495057))),
    headlineSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 25, color: Color(0xff495057))),
    titleLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 18, color: Color(0xff495057))),
    titleMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 17, color: Color(0xff495057))),
    titleSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(0xff495057))),
    bodyLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 16, color: Color(0xff495057))),
    bodyMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 14, color: Color(0xff495057))),
    labelLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(0xff495057))),
    bodySmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 13, color: Color(0xff495057))),
    labelSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 11, color: Color(0xff495057))),
  );

  //Text Themes
  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 102, color: Color(0xff4a4c4f))),
    displayMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 64, color: Color(0xff4a4c4f))),
    displaySmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 51, color: Color(0xff4a4c4f))),
    headlineMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 36, color: Color(0xff4a4c4f))),
    headlineSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 25, color: Color(0xff4a4c4f))),
    titleLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 18, color: Color(0xff4a4c4f))),
    titleMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 17, color: Color(0xff4a4c4f))),
    titleSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(0xff4a4c4f))),
    bodyLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 16, color: Color(0xff4a4c4f))),
    bodyMedium: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 14, color: Color(0xff4a4c4f))),
    labelLarge: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(0xff4a4c4f))),
    bodySmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 13, color: Color(0xff4a4c4f))),
    labelSmall: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 11, color: Color(0xff4a4c4f))),
  );

  //Color Themes
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xee2aaaaa),
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Color(0xfff6f6f6),
    appBarTheme: AppBarTheme(
      //textTheme: lightAppBarTextTheme,
      actionsIconTheme: IconThemeData(
        color: Color(0xff495057),
      ),
      color: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057), size: 24),
    ),
    navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme:
            IconThemeData(color: Color(0xff3d63ff), opacity: 1, size: 24),
        unselectedIconTheme:
            IconThemeData(color: Color(0xff495057), opacity: 1, size: 24),
        backgroundColor: Color(0xffffffff),
        elevation: 3,
        selectedLabelTextStyle: TextStyle(color: Color(0xff3d63ff)),
        unselectedLabelTextStyle: TextStyle(color: Color(0xff495057))),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.4),
      elevation: 1,
      margin: EdgeInsets.all(0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 15, color: Color(0xaa495057)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Color(0xff3d63ff)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.black54),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.black54)),
    ),
    splashColor: Colors.white.withAlpha(100),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: lightTextTheme,
    indicatorColor: Colors.white,
    disabledColor: Color(0xffdcc7ff),
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff3d63ff),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: Color(0xff3d63ff),
        hoverColor: Color(0xff3d63ff),
        foregroundColor: Colors.white),
    dividerColor: Color(0xffd1d1d1),
    cardColor: Colors.white,

    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xffffffff),
      textStyle:
          lightTextTheme.bodyMedium!.merge(TextStyle(color: Color(0xff495057))),
    ),
    bottomAppBarTheme:
        BottomAppBarTheme(color: Color(0xffffffff), elevation: 2),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff3d63ff),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xff3d63ff),
      inactiveTrackColor: Color(0xff3d63ff).withAlpha(140),
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: Color(0xff3d63ff),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
      ),
    ), colorScheme: ColorScheme.light(
        primary: Color(0xff3d63ff),
        onPrimary: Colors.white,
        secondary: Color(0xff495057),
        onSecondary: Colors.white,
        surface: Color(0xffe2e7f1),
        onSurface: Color(0xff495057)).copyWith(surface: Color(0xfff6f6f6)),
  );
}

class CustomAppTheme {
  final Color bgLayer1,
      bgLayer2,
      bgLayer3,
      bgLayer4,
      disabledColor,
      onDisabled,
      colorInfo,
      colorWarning,
      colorSuccess,
      colorError,
      shadowColor,
      onInfo,
      onWarning,
      onSuccess,
      onError;

  final Color groceryBg1, groceryBg2;
  final Color groceryPrimary, groceryOnPrimary;

  final Color medicarePrimary, medicareOnPrimary;

  final Color cookifyPrimary, cookifyOnPrimary;

  final Color lightBlack,
      red,
      green,
      yellow,
      orange,
      blue,
      purple,
      pink,
      brown,
      violet,
      indigo;

  CustomAppTheme({
    this.bgLayer1 = const Color(0xffffffff),
    this.bgLayer2 = const Color(0xfff8faff),
    this.bgLayer3 = const Color(0xfff8f8f8),
    this.bgLayer4 = const Color(0xffdcdee3),
    this.disabledColor = const Color(0xffdcc7ff),
    this.onDisabled = const Color(0xffffffff),
    this.colorWarning = const Color(0xffffc837),
    this.colorInfo = const Color(0xffff784b),
    this.colorSuccess = const Color(0xff3cd278),
    this.shadowColor = const Color(0xff1f1f1f),
    this.onInfo = const Color(0xffffffff),
    this.onWarning = const Color(0xffffffff),
    this.onSuccess = const Color(0xffffffff),
    this.colorError = const Color(0xfff0323c),
    this.onError = const Color(0xffffffff),

    //Grocery color scheme

    this.groceryPrimary = const Color(0xff10bb6b),
    this.groceryOnPrimary = const Color(0xffffffff),
    this.groceryBg1 = const Color(0xfffbfbfb),
    this.groceryBg2 = const Color(0xfff5f5f5),

    //Cookify
    this.cookifyPrimary = const Color(0xffdf7463),
    this.cookifyOnPrimary = const Color(0xffffffff),

    //Color
    this.lightBlack = const Color(0xffa7a7a7),
    this.red = const Color(0xffFF0000),
    this.green = const Color(0xff008000),
    this.yellow = const Color(0xfffff44f),
    this.orange = const Color(0xffFFA500),
    this.blue = const Color(0xff0000ff),
    this.purple = const Color(0xff800080),
    this.pink = const Color(0xffFFC0CB),
    this.brown = const Color(0xffA52A2A),
    this.indigo = const Color(0xff4B0082),
    this.violet = const Color(0xff9400D3),
    //Medicare Color Scheme
    this.medicarePrimary = const Color(0xff6d65df),
    this.medicareOnPrimary = const Color(0xffffffff),
  });
  static final CustomAppTheme lightCustomAppTheme = CustomAppTheme(
    bgLayer1: Color(0xffffffff),
    bgLayer2: Color(0xfff9f9f9),
    bgLayer3: Color(0xffe8ecf4),
    bgLayer4: Color(0xffdcdee3),
    disabledColor: Color(0xff636363),
    onDisabled: Color(0xffffffff),
    colorInfo: Color(0xffff784b),
    colorWarning: Color(0xffffc837),
    colorSuccess: Color(0xff3cd278),
    shadowColor: Color(0xffd9d9d9),
    onInfo: Color(0xffffffff),
    onSuccess: Color(0xffffffff),
    onWarning: Color(0xffffffff),
    colorError: Color(0xfff0323c),
    onError: Color(0xffffffff),
  );
}

class NavigationBarTheme {
  Color? backgroundColor,
      selectedItemIconColor,
      selectedItemTextColor,
      selectedItemColor,
      selectedOverlayColor,
      unselectedItemIconColor,
      unselectedItemTextColor,
      unselectedItemColor;
}


