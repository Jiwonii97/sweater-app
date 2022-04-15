import 'package:flutter/material.dart';

class GlobalTheme {
  GlobalTheme();

  static const Color _lightPrimary900 = Color(0xff285489);
  static const Color _lightPrimary800 = Color(0xff3174ac);
  static const Color _lightPrimary700 = Color(0xff3684c0);
  static const Color _lightPrimary600 = Color(0xff3c97d4);
  static const Color _lightPrimary500 = Color(0xff41a5e3);
  static const Color _lightPrimary400 = Color(0xff4db2e7);
  static const Color _lightPrimary300 = Color(0xff62bfeb);
  static const Color _lightPrimary200 = Color(0xff89d1f2);
  static const Color _lightPrimary100 = Color(0xffb6e3f7);
  static const Color _lightPrimary50 = Color(0xffe2f4fc);

  static const Color _gray900 = Color(0xff212121);
  static const Color _gray800 = Color(0xff424242);
  static const Color _gray700 = Color(0xff616161);
  static const Color _gray600 = Color(0xff757575);
  static const Color _gray500 = Color(0xff9E9E9E);
  static const Color _gray400 = Color(0xffBDBDBD);
  static const Color _gray300 = Color(0xffE0E0E0);
  static const Color _gray200 = Color(0xffEEEEEE);
  static const Color _gray100 = Color(0xffF5F5F5);
  static const Color _gray50 = Color(0xffFAFAFA);

  static const Color _blueGray900 = Color(0xff263238);
  static const Color _blueGray800 = Color(0xff37474F);
  static const Color _blueGray700 = Color(0xff455A64);
  static const Color _blueGray600 = Color(0xff546E7A);
  static const Color _blueGray500 = Color(0xff607D8B);
  static const Color _blueGray400 = Color(0xff78909C);
  static const Color _blueGray300 = Color(0xff90A4AE);
  static const Color _blueGray200 = Color(0xffB0BEC5);
  static const Color _blueGray100 = Color(0xffCFD8DC);
  static const Color _blueGray50 = Color(0xffECEFF1);

  static const Color _error900 = Color(0xffb00020);
  static const Color _error800 = Color(0xffbf152c);
  static const Color _error700 = Color(0xffcc1d33);
  static const Color _error600 = Color(0xffde2839);
  static const Color _error500 = Color(0xffed323b);
  static const Color _error400 = Color(0xffe84853);
  static const Color _error300 = Color(0xffde6c74);
  static const Color _error200 = Color(0xffea959b);
  static const Color _error100 = Color(0xfffbcad2);
  static const Color _error50 = Color(0xfffdeaee);

  static const Color _red900 = Color(0xff7A221B);
  static const Color _red800 = Color(0xff992A22);
  static const Color _red700 = Color(0xffB73229);
  static const Color _red600 = Color(0xffD63B2F);
  static const Color _red500 = Color(0xffF44336);
  static const Color _red400 = Color(0xffF66257);
  static const Color _red300 = Color(0xffF88279);
  static const Color _red200 = Color(0xffFAA19B);
  static const Color _red100 = Color(0xffFCC7C3);
  static const Color _red50 = Color(0xffFEECEB);

  static const Color _blue900 = Color(0xff01579b);
  static const Color _blue800 = Color(0xff0277bd);
  static const Color _blue700 = Color(0xff0288d1);
  static const Color _blue600 = Color(0xff039be5);
  static const Color _blue500 = Color(0xff03a9f4);
  static const Color _blue400 = Color(0xff29b6f6);
  static const Color _blue300 = Color(0xff4fc3f7);
  static const Color _blue200 = Color(0xff81d4fa);
  static const Color _blue100 = Color(0xffb3e5fc);
  static const Color _blue50 = Color(0xffe1f5fe);

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
      colorScheme: const ColorScheme.light(
        surface: Color(0xffFFFFFF),
        background: Color(0xffFFFFFF),
        error: _error500,
        onPrimary: Color(0xff121212),
        onSecondary: Color(0xff121212),
        onSurface: Color(0xff121212),
        onBackground: Color(0xff121212),
        onError: Color(0xffFFFFFF),
        brightness: Brightness.light,
      ),
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
  static final ThemeData darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
        surface: _gray900,
        background: Color(0xffffffff),
        error: _error500,
        onPrimary: Color(0xffffffff),
        onSecondary: Color(0xffffffff),
        onSurface: Color(0xffffffff),
        onBackground: Color(0xffffffff),
        onError: Color(0xffFFFFFF),
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true, // 텍스트 중앙 배치
        backgroundColor: Colors.transparent, // 배경 투명하게
        foregroundColor: const Color(0xffffffff),
        elevation: 0, // 기본 degree는 0으로
        titleTextStyle: _headline6Text.copyWith(color: const Color(0xffffffff)),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: _lightBackgroundColor,
        elevation: 16,
      ),
      textTheme: TextTheme(
        headline1: _headline1Text.copyWith(color: const Color(0xffffffff)),
        headline2: _headline2Text.copyWith(color: const Color(0xffffffff)),
        headline3: _headline3Text.copyWith(color: const Color(0xffffffff)),
        headline4: _headline4Text.copyWith(color: const Color(0xffffffff)),
        headline5: _headline5Text.copyWith(color: const Color(0xffffffff)),
        headline6: _headline6Text.copyWith(color: const Color(0xffffffff)),
        subtitle1: _subtitle1Text.copyWith(color: const Color(0xffffffff)),
        subtitle2: _subtitle2Text.copyWith(color: const Color(0xffffffff)),
        bodyText1: _body1Text.copyWith(color: const Color(0xffffffff)),
        bodyText2: _body2Text.copyWith(color: const Color(0xffffffff)),
        button: _buttonText.copyWith(color: const Color(0xffffffff)),
        caption: _captionText.copyWith(color: const Color(0xffffffff)),
        overline: _overlineText.copyWith(color: const Color(0xffffffff)),
      ),
      fontFamily: 'NotoSansKR',
      primaryColor: _lightPrimaryColor,
      errorColor: _lightErrorColor);
}
