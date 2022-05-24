import 'dart:math';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:sweater/theme/sweater_icons.dart';
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
              context.read<WeatherProvider>().getCurrentWeather(),
              context.read<UserProvider>().user,
              pageKey: context.read<CoordiProvider>().pageKey,
              pageIndex: context.read<CoordiProvider>().pageIndex);
        },
        child: CheckMenu(
          title: constitutionList[index]['constitutionString'],
          checked: context.watch<UserProvider>().constitution ==
              constitutionList[index]['constitutionValue'],
        ),
      );
    });
    checkboxList
        .add(GuideText(guideText: "체질 설정을 통해 본인의 체질에 맞는 코디를 추천받을 수 있습니다."));
    return Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(SweaterIcons.arrow_left),
                onPressed: () => Navigator.pop(context))),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: checkboxList));
  }
}
