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
  static const Color _iconColor = Color(0xff2B3137);

  static const Color _lightPrimaryColor = Color(0xff0E7EB8);
  static const Color _lightPrimaryVariantColor = Color(0xff004B72);
  static const Color _lightBackgroundColor = Color(0xffFFFFFF);
  static const Color _lightSurfaceColor = Color(0xffFFFFFF);
  static const Color _lightErrorColor = Color(0xffDD3730);
  static const Color _lightOnPrimaryColor = Color(0xff121212);
  static const Color _lightOnSurfaceColor = Color(0xff121212);
  static const Color _lightOnBackgroundColor = Color(0xff121212);
  static const Color _lightOnErrorColor = Color(0xffFEFEFE);
  static Color get lightOnErrorColor => _lightOnErrorColor;

  static const Color _lightOnSky = Color(0xffFFFFFF);
  static Color get lightOnSky => _lightOnSky;

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true, // 텍스트 중앙 배치
        backgroundColor: Colors.transparent, // 배경 투명하게
        foregroundColor: _lightOnBackgroundColor,
        elevation: 0, // 기본 degree는 0으로
        titleTextStyle: TextStyle(
            color: _lightOnBackgroundColor,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: _lightBackgroundColor,
        elevation: 16,
      ),
      errorColor: _lightErrorColor);
}
