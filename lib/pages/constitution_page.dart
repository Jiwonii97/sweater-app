import 'dart:math';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:sweater/widgets/check_menu.dart';
import 'package:provider/provider.dart';
import 'package:sweater/module/constitution.dart';

class ConstitutionManagePage extends StatefulWidget {
  const ConstitutionManagePage({Key? key}) : super(key: key);

  @override
  State<ConstitutionManagePage> createState() => _ConstitutionManagePage();
}

class _ConstitutionManagePage extends State<ConstitutionManagePage> {
  _ConstitutionManagePage();

  @override
  Widget build(BuildContext context) {
    String _title = "체질 관리";
    List<Map<String, dynamic>> constitutionList = [
      {
        'constitutionValue': Constitution.feelVeryHot,
        'constitutionString': Constitution.feelVeryHotString,
      },
      {
        'constitutionValue': Constitution.feelHot,
        'constitutionString': Constitution.feelHotString,
      },
      {
        'constitutionValue': Constitution.feelNormal,
        'constitutionString': Constitution.feelNormalString,
      },
      {
        'constitutionValue': Constitution.feelCold,
        'constitutionString': Constitution.feelColdString,
      },
      {
        'constitutionValue': Constitution.feelVeryCold,
        'constitutionString': Constitution.feelVeryColdString,
      },
    ];
    return Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(constitutionList.length, (index) {
              return GestureDetector(
                onTap: () {
                  context.read<UserProvider>().changeConstitution(
                      constitutionList[index]['constitutionValue']);
                  context.read<CoordiProvider>().requestCoordiList(
                      context.read<Weather>().forecastList,
                      0,
                      context.read<UserProvider>().gender,
                      context.read<UserProvider>().constitution);
                },
                child: CheckMenu(
                  title: constitutionList[index]['constitutionString'],
                  checked: context.watch<UserProvider>().constitution ==
                      Constitution.feelVeryHot,
                ),
              );
            })));
  }
}

// GestureDetector(
//                   onTap: () {
//                     context
//                         .read<UserProvider>()
//                         .changeConstitution(constitution.constitutionValue);
//                     context.read<CoordiProvider>().requestCoordiList(
//                         context.read<Weather>().forecastList,
//                         0,
//                         context.read<UserProvider>().gender,
//                         context.read<UserProvider>().constitution);
//                   },
//                   child: CheckMenu(
//                     title: "더위를 많이 타요",
//                     checked: context.watch<UserProvider>().constitution ==
//                         ConstitutionValue.veryHot,
//                   ),
//                 ),
//               GestureDetector(
//                 onTap: () {
//                   context
//                       .read<UserProvider>()
//                       .changeConstitution(ConstitutionValue.hot);
//                   context.read<CoordiProvider>().requestCoordiList(
//                       context.read<Weather>().forecastList,
//                       0,
//                       context.read<UserProvider>().gender,
//                       context.read<UserProvider>().constitution);
//                 },
//                 child: CheckMenu(
//                   title: "더위를 조금 타요",
//                   checked: context.watch<UserProvider>().constitution ==
//                       ConstitutionValue.hot,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   context
//                       .read<UserProvider>()
//                       .changeConstitution(ConstitutionValue.normal);
//                   context.read<CoordiProvider>().requestCoordiList(
//                       context.read<Weather>().forecastList,
//                       0,
//                       context.read<UserProvider>().gender,
//                       context.read<UserProvider>().constitution);
//                 },
//                 child: CheckMenu(
//                   title: "보통이에요",
//                   checked: context.watch<UserProvider>().constitution ==
//                       ConstitutionValue.normal,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   context
//                       .read<UserProvider>()
//                       .changeConstitution(ConstitutionValue.cold);
//                   context.read<CoordiProvider>().requestCoordiList(
//                       context.read<Weather>().forecastList,
//                       0,
//                       context.read<UserProvider>().gender,
//                       context.read<UserProvider>().constitution);
//                 },
//                 child: CheckMenu(
//                   title: "추위를 조금 타요",
//                   checked: context.watch<UserProvider>().constitution ==
//                       ConstitutionValue.cold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   context
//                       .read<UserProvider>()
//                       .changeConstitution(ConstitutionValue.veryCold);
//                   context.read<CoordiProvider>().requestCoordiList(
//                       context.read<Weather>().forecastList,
//                       0,
//                       context.read<UserProvider>().gender,
//                       context.read<UserProvider>().constitution);
//                 },
//                 child: CheckMenu(
//                   title: "추위를 많이 타요",
//                   checked: context.watch<UserProvider>().constitution ==
//                       ConstitutionValue.veryCold,
//                 ),
//               ),