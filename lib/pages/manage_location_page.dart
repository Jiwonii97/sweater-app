import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/widgets/location_tile.dart';
import 'package:sweater/widgets/check_menu.dart';
import 'package:sweater/pages/add_location_page.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/theme/sweater_icons.dart';

class ManageLocationPage extends StatefulWidget {
  const ManageLocationPage({Key? key}) : super(key: key);

  @override
  State<ManageLocationPage> createState() => _ManageLocationPage();
}

class _ManageLocationPage extends State<ManageLocationPage> {
  bool init = false;
  List<Widget> locList = [];
  List selects = [];
  late SharedPreferences prefs;

  void deleteLoc(String title) {
    context.read<Location>().deleteLoc(title);
    setState(() {});
  }

  List<Widget> readLocList() {
    if (locList.isNotEmpty) {
      locList = [];
    }

    for (var location in context.watch<Location>().location) {
      locList.add(GestureDetector(
        onTap: () => setState(() {
          context.read<Location>().cur = location["name"];
          context.read<Location>().saveAll();
          context.read<Weather>().changeActiveFlag();
          String xValue = context.read<Location>().X.toString();
          String yValue = context.read<Location>().Y.toString();
          context.read<Weather>().updateWeather(xValue, yValue).then((value) =>
              value == 0
                  ? context.read<CoordiProvider>().requestCoordiList(
                      context.read<Weather>().forecastList,
                      0,
                      context.read<UserProvider>().gender,
                      context.read<UserProvider>().constitution)
                  : debugPrint("fail getting weather api"));

          setState(() {});
        }),
        child: context.read<Location>().cur == location['name']
            ? CheckMenu(
                isLocation: true,
                leadingIcon: SweaterIcons.map_marker_alt,
                title: location['name'],
                checked: context.read<Location>().cur == location['name'],
              )
            : LocationTile(
                onPressButton: deleteLoc,
                title: location['name'],
                checked: context.read<Location>().cur == location['name'],
              ),
      ));
    }

    setState(() {});
    return locList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text('위치 관리'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddLocationPage()));
                },
                icon: Icon(SweaterIcons.plus))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: readLocList(),
        ));
  }
}
