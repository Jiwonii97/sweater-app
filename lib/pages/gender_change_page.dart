import 'package:flutter/material.dart';
import 'package:sweater/widgets/check_menu.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/module/gender.dart';

class GenderChangePage extends StatefulWidget {
  const GenderChangePage({Key? key}) : super(key: key);

  @override
  State<GenderChangePage> createState() => _GenderChangePage();
}

class _GenderChangePage extends State<GenderChangePage> {
  final String _title = "성별 관리";
  @override
  Widget build(BuildContext context) {
    var weatherConsumer = Provider.of<WeatherProvider>(context);
    var userConsumer = Provider.of<UserProvider>(context);
    var coordiConsumer = Provider.of<CoordiProvider>(context);
    List<Map<String, dynamic>> genderList = [
      {
        'gender': Gender.man,
        'icon': Icons.boy,
        'genderString': Gender.manString
      },
      {
        'gender': Gender.woman,
        'icon': Icons.woman,
        'genderString': Gender.womanString
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
            children: List.generate(genderList.length, (int index) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<UserProvider>()
                      .changeGender(genderList[index]['gender']);
                  coordiConsumer.requestCoordiList(weatherConsumer.forecastList,
                      0, userConsumer.gender, userConsumer.constitution);
                },
                child: CheckMenu(
                  leadingIcon: genderList[index]['icon'],
                  title: genderList[index]['genderString'],
                  checked: context.watch<UserProvider>().gender ==
                      genderList[index]['gender'],
                ),
              );
            })));
  }
}
