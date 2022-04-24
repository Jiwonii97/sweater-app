import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/theme/global_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //비동기 처리를 위해 추가
  await Firebase.initializeApp(); //파이어베이스 등록
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<CoordiProvider>(
              create: (context) => CoordiProvider()),
          ChangeNotifierProvider<WeatherProvider>(
              create: (context) => WeatherProvider()),
          ChangeNotifierProvider<LocationProvider>(
              create: (context) => LocationProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: GlobalTheme.lightTheme,
            home: const HomePage()));
  }
}
