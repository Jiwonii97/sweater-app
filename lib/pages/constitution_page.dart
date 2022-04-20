import 'dart:math';
import 'package:sweater/providers/user_info.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          GestureDetector(
            onTap: () {
              context
                  .read<User>()
                  .changeConstitution(ConstitutionValue.veryHot);
              context.read<CoordiProvider>().requestCoordiList(
                  context.read<Weather>().forecastList,
                  0,
                  context.read<User>().gender,
                  context.read<User>().constitution);
            },
            child: CheckMenu(
              title: "더위를 많이 타요",
              checked: context.watch<User>().constitution ==
                  ConstitutionValue.veryHot,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<User>().changeConstitution(ConstitutionValue.hot);
              context.read<CoordiProvider>().requestCoordiList(
                  context.read<Weather>().forecastList,
                  0,
                  context.read<User>().gender,
                  context.read<User>().constitution);
            },
            child: CheckMenu(
              title: "더위를 조금 타요",
              checked:
                  context.watch<User>().constitution == ConstitutionValue.hot,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<User>().changeConstitution(ConstitutionValue.normal);
              context.read<CoordiProvider>().requestCoordiList(
                  context.read<Weather>().forecastList,
                  0,
                  context.read<User>().gender,
                  context.read<User>().constitution);
            },
            child: CheckMenu(
              title: "보통이에요",
              checked: context.watch<User>().constitution ==
                  ConstitutionValue.normal,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<User>().changeConstitution(ConstitutionValue.cold);
              context.read<CoordiProvider>().requestCoordiList(
                  context.read<Weather>().forecastList,
                  0,
                  context.read<User>().gender,
                  context.read<User>().constitution);
            },
            child: CheckMenu(
              title: "추위를 조금 타요",
              checked:
                  context.watch<User>().constitution == ConstitutionValue.cold,
            ),
          ),
          GestureDetector(
            onTap: () {
              context
                  .read<User>()
                  .changeConstitution(ConstitutionValue.veryCold);
              context.read<CoordiProvider>().requestCoordiList(
                  context.read<Weather>().forecastList,
                  0,
                  context.read<User>().gender,
                  context.read<User>().constitution);
            },
            child: CheckMenu(
              title: "추위를 많이 타요",
              checked: context.watch<User>().constitution ==
                  ConstitutionValue.veryCold,
            ),
          ),
        ]));
  }
}

class ConstitutionValue {
  static int veryCold = -2;
  static int cold = -1;
  static int normal = 0;
  static int hot = 1;
  static int veryHot = 2;
}
