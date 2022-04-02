import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/home_page.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/user_info.dart';
import 'package:sweater/providers/weather.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //비동기 처리를 위해 추가
  await Firebase.initializeApp(); //파이어베이스 등록
  HttpOverrides.global = MyHttpOverrides();
  // QuerySnapshot qs =
  //     await FirebaseFirestore.instance.collection('coordis').get();
  // CoordiProvider _coordiProvider;

  // _coordiProvider = Provider.of<CoordiProvider>();
  // _coordiProvider.addCoordiList(qs);
  // print(qs.docs[0].data());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<User>(create: (context) => User()),
          ChangeNotifierProvider<CoordiProvider>(
              create: (context) => CoordiProvider()),
          ChangeNotifierProvider<Weather>(create: (context) => Weather()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage()));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
