import 'package:flutter/material.dart';

class GlobalTheme {
  GlobalTheme();

  static const Map<int, Color> _lightPrimaryPalette = <int, Color>{
    900: Color(0xff285489),
    800: Color(0xff3174ac),
    700: Color(0xff3684c0),
    600: Color(0xff3c97d4),
    500: Color(0xff41a5e3),
    400: Color(0xff4db2e7),
    300: Color(0xff62bfeb),
    200: Color(0xff89d1f2),
    100: Color(0xffb6e3f7),
    50: Color(0xffe2f4fc),
  };
  static const Map<int, Color> _gray = <int, Color>{
    900: Color(0xff212121),
    800: Color(0xff424242),
    700: Color(0xff616161),
    600: Color(0xff757575),
    500: Color(0xff9E9E9E),
    400: Color(0xffBDBDBD),
    300: Color(0xffE0E0E0),
    200: Color(0xffEEEEEE),
    100: Color(0xffF5F5F5),
    50: Color(0xffFAFAFA),
  };
  static const Map<int, Color> _blueGray = <int, Color>{
    900: Color(0xff263238),
    800: Color(0xff37474F),
    700: Color(0xff455A64),
    600: Color(0xff546E7A),
    500: Color(0xff607D8B),
    400: Color(0xff78909C),
    300: Color(0xff90A4AE),
    200: Color(0xffB0BEC5),
    100: Color(0xffCFD8DC),
    50: Color(0xffECEFF1),
  };
  static const Map<int, Color> _error = <int, Color>{
    900: Color(0xffb00020),
    800: Color(0xffbf152c),
    700: Color(0xffcc1d33),
    600: Color(0xffde2839),
    500: Color(0xffed323b),
    400: Color(0xffe84853),
    300: Color(0xffde6c74),
    200: Color(0xffea959b),
    100: Color(0xfffbcad2),
    50: Color(0xfffdeaee),
  };
  final Color _iconColor = const Color(0xff2B3137);

  static const Color _lightPrimaryColor = Color(0xff0E7EB8);
  static const Color _lightPrimaryVariantColor = Color(0xff004B72);
  static const Color _lightBackgroundColor = Color(0xffFFFFFF);
  static const Color _lightSurfaceColor = Color(0xffFFFFFF);
  static const Color _lightErrorColor = Color(0xffDD3730);
  static const Color _lightOnPrimaryColor = Color(0xff121212);
  static const Color _lightOnSurfaceColor = Color(0xff121212);
  static const Color _lightOnBackgroundColor = Color(0xff121212);
  static const Color _lightOnErrorColor = Color(0xffFEFEFE);
  Color get lightOnErrorColor => _lightOnErrorColor;

  final Color _lightOnSky = const Color(0xffFFFFFF);
  Color get lightOnSky => _lightOnSky;

  static const _headline1Text = TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 96,
      letterSpacing: -1.5,
      color: Color(0xff212121));
  static const _headline2Text = TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 60,
      letterSpacing: -0.5,
      color: Color(0xff212121));
  static const _headline3Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 48,
      letterSpacing: 0,
      color: Color(0xff212121));
  static const _headline4Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 34,
      letterSpacing: 0.25,
      color: Color(0xff212121));
  static const _headline5Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 24,
      letterSpacing: 0,
      color: Color(0xff212121));
  static const _headline6Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 20,
      letterSpacing: 0.15,
      color: Color(0xff212121));
  static const _subtitle1Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0.15,
      color: Color(0xff616161));
  static const _subtitle2Text = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
      color: Color(0xff616161));
  static const _body1Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0.5,
      color: Color(0xff424242));
  static const _body2Text = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.25,
      color: Color(0xff424242));
  static const _buttonText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 1.25,
      color: Color(0xff212121));
  static const _captionText = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.4,
      color: Color(0xff757575));
  static const _overlineText = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      letterSpacing: 1.5,
      color: Color(0xff757575));

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true, // 텍스트 중앙 배치
        backgroundColor: Colors.transparent, // 배경 투명하게
        foregroundColor: _lightOnBackgroundColor,
        elevation: 0, // 기본 degree는 0으로
        titleTextStyle: _headline6Text,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: _lightBackgroundColor,
        elevation: 16,
      ),
      textTheme: const TextTheme(
        headline1: _headline1Text,
        headline2: _headline2Text,
        headline3: _headline3Text,
        headline4: _headline4Text,
        headline5: _headline5Text,
        headline6: _headline6Text,
        subtitle1: _subtitle1Text,
        subtitle2: _subtitle2Text,
        bodyText1: _body1Text,
        bodyText2: _body2Text,
        button: _buttonText,
        caption: _captionText,
        overline: _overlineText,
      ),
      fontFamily: 'NotoSansKR',
      primaryColor: _lightPrimaryColor,
      errorColor: _lightErrorColor);
}
