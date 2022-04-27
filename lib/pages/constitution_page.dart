import 'dart:math';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:sweater/widgets/check_menu.dart';
import 'package:provider/provider.dart';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/widgets/guide_text.dart';

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
    List<Widget> checkboxList = List.generate(constitutionList.length, (index) {
      return GestureDetector(
        onTap: () {
          context
              .read<UserProvider>()
              .changeConstitution(constitutionList[index]['constitutionValue']);
          context.read<CoordiProvider>().requestCoordiList(
              context.read<WeatherProvider>().forecastList,
              0,
              context.read<UserProvider>().gender,
              context.read<UserProvider>().constitution);
        },
        child: CheckMenu(
          title: constitutionList[index]['constitutionString'],
          checked: context.watch<UserProvider>().constitution ==
              constitutionList[index]['constitutionValue'],
        ),
      );
    });
    checkboxList.add(GuideText(guide: "constitution"));
    return Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: checkboxList));
  }
}
