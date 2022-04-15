// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sweater/components/card_container.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _title = "SWEATER";
  var currentWeather;
  Color colorByWeather() {
    return Colors.white;
  }

  @override
  void initState() {
    super.initState();
    var coordiConsumer = Provider.of<CoordiProvider>(context, listen: false);
    var weatherConsumer = Provider.of<Weather>(context, listen: false);
    var userConsumer = Provider.of<User>(context, listen: false);

    coordiConsumer.initCoordiList(
        weatherConsumer.forecastList, userConsumer.gender);
  }

  @override
  Widget build(BuildContext context) {
    String xValue = context.read<Location>().X.toString();
    String yValue = context.read<Location>().Y.toString();
    context.read<Weather>().updateWeather(xValue, yValue);
    currentWeather = context.watch<Weather>().forecastList[0];

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background-sky.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                title: Text(
                  context.watch<Location>().cur.split(' ').last,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: colorByWeather()),
                ),
                leading: Builder(
                    builder: (context) => IconButton(
                        icon: Icon(SweaterIcons.bars, color: colorByWeather()),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        }))),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    WeatherView(
                      hourForecast: currentWeather,
                    ),
                    const CardContainer(child: CoordiSection()),
                  ]),
            ),
            drawer: Drawer(
                child: ListView(
              children: <Widget>[
                DrawerHeader(
                    child: Text(_title,
                        style: Theme.of(context).textTheme.headline4),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor)),
                ListTile(
                    leading: const Icon(SweaterIcons.map_marker_alt),
                    title: const Text("지역 관리"),
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
                    title: const Text("성별 설정"),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GenderChangePage()))
                        }),
                ListTile(
                    leading: const Icon(SweaterIcons.tint),
                    title: const Text("체질 관리"),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConstitutionManagePage()))
                        }),
              ],
            ))));
  }
}
