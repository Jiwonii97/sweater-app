import 'package:flutter/material.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/providers/user_info.dart';
import 'package:sweater/providers/weather.dart';
import 'package:provider/provider.dart';

class GenderChangePage extends StatefulWidget {
  const GenderChangePage({Key? key}) : super(key: key);

  @override
  State<GenderChangePage> createState() => _GenderChangePage();
}

class _GenderChangePage extends State<GenderChangePage> {
  final String _title = "성별 관리";
  @override
  Widget build(BuildContext context) {
    var weatherConsumer = Provider.of<Weather>(context);
    var userConsumer = Provider.of<User>(context);
    var coordiConsumer = Provider.of<CoordiProvider>(context);

    return Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  context.read<User>().changeGender(User.man);
                  coordiConsumer.requestCoordiList(weatherConsumer.forecastList,
                      0, userConsumer.gender, userConsumer.constitution);
                },
                child: CheckMenu(
                  leadingIcon: Icons.boy,
                  title: User.manString,
                  checked: context.watch<User>().gender == User.man,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<User>().changeGender(User.woman);
                  coordiConsumer.requestCoordiList(weatherConsumer.forecastList,
                      0, userConsumer.gender, userConsumer.constitution);
                },
                child: CheckMenu(
                  leadingIcon: Icons.girl,
                  title: User.womanString,
                  checked: context.watch<User>().gender == User.woman,
                ),
              ),
            ]));
  }
}
