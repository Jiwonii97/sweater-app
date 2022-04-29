import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/widgets/guide_dialog.dart';
import 'package:sweater/module/location.dart';
import 'package:sweater/widgets/location_tile.dart';
import 'package:sweater/widgets/check_menu.dart';
import 'package:sweater/pages/add_location_page.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/theme/sweater_icons.dart';

class ManageLocationPage extends StatefulWidget {
  const ManageLocationPage({Key? key}) : super(key: key);

  @override
  State<ManageLocationPage> createState() => _ManageLocationPage();
}

class _ManageLocationPage extends State<ManageLocationPage> {
  bool init = false;
  List<Widget> locationList = [];
  List selects = [];
  late SharedPreferences prefs;

  void deleteLocation(Location location) {
    context.read<LocationProvider>().deleteLocation(location);
    setState(() {});
  }

  List<Widget> readLocationList() {
    if (locationList.isNotEmpty) {
      locationList = [];
    }

    for (var location in context.watch<LocationProvider>().locationList) {
      locationList.add(GestureDetector(
        onTap: () => setState(() {
          context.read<LocationProvider>().current = location;
          context.read<LocationProvider>().saveAll();
          // context.read<WeatherProvider>().changeActiveFlag();
          int xValue = context.read<LocationProvider>().current.X;
          int yValue = context.read<LocationProvider>().current.Y;
          context.read<WeatherProvider>().updateWeather(xValue, yValue).then(
              (value) => value == 0
                  ? context.read<CoordiProvider>().requestCoordiList(
                      context.read<WeatherProvider>().forecastList,
                      0,
                      context.read<UserProvider>().gender,
                      context.read<UserProvider>().constitution)
                  : debugPrint("fail getting weather api"));

          setState(() {});
        }),
        child:
            context.read<LocationProvider>().current.address == location.address
                ? CheckMenu(
                    isLocation: true,
                    leadingIcon: SweaterIcons.map_marker_alt,
                    title: location.address,
                    checked: context.read<LocationProvider>().current.address ==
                        location.address,
                  )
                : LocationTile(
                    onPressButton: deleteLocation,
                    location: location,
                    checked: context.read<LocationProvider>().current.address ==
                        location.address,
                  ),
      ));
    }

    setState(() {});
    return locationList;
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: GuideDialog());
                      });
                },
                icon: const Icon(SweaterIcons.question_circle)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddLocationPage()));
                },
                icon: const Icon(SweaterIcons.plus)),
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: readLocationList(),
          ),
        ));
  }
}
