// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sweater/components/card_container.dart';
import 'package:sweater/theme/global_theme.dart';
// import 'package:sweater/components/hourly_weather_section.dart';
import 'package:sweater/pages/gender_change_page.dart';
import 'package:sweater/pages/manage_location_page.dart';
import 'package:sweater/pages/constitution_page.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/theme/sweater_icons.dart';
// import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/providers/user_info.dart';
import '../components/coordi_section.dart';
import '../components/weather_view.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _title = "SWEATER";
  ThemeData themeByWeather() {
    // return Random().nextInt(2) == 1
    // ? GlobalTheme.darkTheme
    HourForecast currentWeather = context.watch<Weather>().getCurrentWeather();
    String skyState = currentWeather.getSky;
    if (skyState == '비' || skyState == '비/눈' || skyState == '눈') {
      return GlobalTheme.darkTheme;
    }
    int currentHour = DateTime.now().hour;
    if (6 <= currentHour && currentHour <= 18) {
      return GlobalTheme.lightTheme;
    }
    return GlobalTheme.darkTheme;
  }

  List<Color> backgroundByWeather() {
    // return [Color(0xff039be5), Color(0xffffffff)];
    return [const Color(0xff00141F), const Color(0x004E77).withOpacity(0)];
  }

  void initCoordi() {
    var coordiConsumer = Provider.of<CoordiProvider>(context, listen: false);
    var weatherConsumer = Provider.of<Weather>(context, listen: false);
    var userConsumer = Provider.of<User>(context, listen: false);

    weatherConsumer.initWeatherFlag
        ? coordiConsumer.initCoordiList(
            weatherConsumer.forecastList, 0, userConsumer.gender)
        : debugPrint("not initialize weather yet");
  }

  @override
  void initState() {
    super.initState();

    String xValue = context.read<Location>().X.toString();
    String yValue = context.read<Location>().Y.toString();

    context.read<Weather>().updateWeather(xValue, yValue).then((value) =>
        value == 0 ? initCoordi() : debugPrint("fail getting weather api"));
  }

  @override
  Widget build(BuildContext context) {
    String xValue = context.read<Location>().X.toString();
    String yValue = context.read<Location>().Y.toString();
    context.read<Weather>().updateWeather(xValue, yValue);
    HourForecast currentWeather = context.watch<Weather>().forecastList[0];

    context.read<Weather>().updateWeather(xValue, yValue);
    return Container(
        color: Colors.white,
        child: Theme(
            data: themeByWeather(),
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: backgroundByWeather()),
                ),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                        title: const Text('SWETAER'),
                        leading: Builder(
                            builder: (context) => IconButton(
                                icon: const Icon(SweaterIcons.bars),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                }))),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            WeatherView(
                              hourForecast:
                                  context.watch<Weather>().getCurrentWeather(),
                            ),
                            const CardContainer(child: CoordiSection()),
                          ]),
                    ),
                    drawer: Drawer(
                        backgroundColor:
                            GlobalTheme.lightTheme.colorScheme.surface,
                        child: ListView(
                          children: <Widget>[
                            DrawerHeader(
                                child: Text(_title,
                                    style: GlobalTheme
                                        .lightTheme.textTheme.headline4),
                                decoration: BoxDecoration(
                                    color:
                                        GlobalTheme.lightTheme.primaryColor)),
                            ListTile(
                                leading: Icon(SweaterIcons.map_marker_alt,
                                    color: GlobalTheme
                                        .lightTheme.colorScheme.onSurface),
                                title: Text(
                                  "지역 관리",
                                  style: GlobalTheme
                                      .lightTheme.textTheme.subtitle2,
                                ),
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ManageLocationPage()))
                                    }),
                            ListTile(
                                leading: Icon(
                                  context.watch<User>().gender == 1
                                      ? SweaterIcons.mars
                                      : SweaterIcons.venus,
                                  color: context.watch<User>().gender == 1
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                                title: Text("성별 설정",
                                    style: GlobalTheme
                                        .lightTheme.textTheme.subtitle2),
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const GenderChangePage()))
                                    }),
                            ListTile(
                                leading: Icon(SweaterIcons.temperature_high,
                                    color: GlobalTheme
                                        .lightTheme.colorScheme.onSurface),
                                title: Text("체질 관리",
                                    style: GlobalTheme
                                        .lightTheme.textTheme.subtitle2),
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ConstitutionManagePage()))
                                    }),
                          ],
                        ))))));
  }
}
