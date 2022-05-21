// import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:eventify/eventify.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:sweater/module/error_type.dart';
import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/module/forecast.dart';
// import 'package:sweater/widgets/hourly_weather_section.dart';
import 'package:sweater/pages/gender_change_page.dart';
import 'package:sweater/pages/manage_location_page.dart';
import 'package:sweater/pages/constitution_page.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/widgets/loading.dart';
import '../widgets/coordi_section.dart';
import '../widgets/weather_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/widgets/first_guide.dart';
import 'package:url_launcher/link.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final String _title = "스웨더";
  late Timer weatherUpdateTimer;
  late bool isFirst = false;
  bool isFilterOpen = false;
  EventEmitter weatherUpdateEmitter = new EventEmitter();
  EventEmitter coordiUpdateEmitter = new EventEmitter();

  ThemeData themeByWeather() {
    // return Random().nextInt(2) == 1
    // ? GlobalTheme.darkTheme
    Forecast currentWeather =
        context.watch<WeatherProvider>().getCurrentWeather();
    String skyState = currentWeather.sky;
    if (skyState == '비' || skyState == '비/눈' || skyState == '눈') {
      return GlobalTheme.darkTheme;
    }
    int currentHour = DateTime.now().hour;
    if (6 <= currentHour && currentHour <= 18) {
      return GlobalTheme.lightTheme;
    }
    return GlobalTheme.darkTheme;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed: //재개하다
        weatherUpdateEmitter.emit('updatePeriodic');
        break;
      case AppLifecycleState.paused:
        weatherUpdateTimer.cancel();
        break;
    }
  }

  List<Color> backgroundByWeather() {
    Forecast currentWeather =
        context.watch<WeatherProvider>().getCurrentWeather();
    String skyState = currentWeather.sky;
    if (skyState == '비' || skyState == '비/눈' || skyState == '눈') {
      return [const Color(0xff00141F), const Color(0x004E77).withOpacity(0)];
    }
    int currentHour = DateTime.now().hour;
    if (6 <= currentHour && currentHour <= 18) {
      return [Color(0xff039be5), Color(0xffffffff)];
    }
    return [const Color(0xff00141F), const Color(0x004E77).withOpacity(0)];
    //return [Color(0xff039be5), Color(0xffffffff)];
    // return [const Color(0xff00141F), const Color(0x004E77).withOpacity(0)];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    final locationProvider = context.read<LocationProvider>();
    final weatherProvider = context.read<WeatherProvider>();
    final coordiProvider = context.read<CoordiProvider>();
    final userProvider = context.read<UserProvider>();
    weatherUpdateEmitter.on("updatePeriodic", null, (evt, cnt) async {
      //정각마다 날씨 갱신
      int initResultCode = await locationProvider.initLocation();
      if (initResultCode == ErrorType.successCode) {
        int xValue = locationProvider.current.X;
        int yValue = locationProvider.current.Y;
        bool isSuccessWeather =
            await weatherProvider.updateWeather(xValue, yValue);
        if (isSuccessWeather) {
          coordiUpdateEmitter.emit("updateCoordi", null, null);
        }
        //60분 뒤에timer 이벤트 발생시키기
        final min = DateTime.now().minute;
        final sec = DateTime.now().second;
        weatherUpdateTimer = Timer(Duration(seconds: (60 - min) * 60 - sec),
            () => weatherUpdateEmitter.emit("updatePeriodic", null));
      }
    });

    coordiUpdateEmitter.on("updateCoordi", null, (evt, cnt) async {
      //코디 갱신
      bool isUpdateCoordiSuccess = await coordiProvider.requestCoordiList(
          weatherProvider.getCurrentWeather(), userProvider.user);
      if (!isUpdateCoordiSuccess) {
        debugPrint("fail getting coordi data");
      }
    });

    weatherUpdateEmitter.emit("updatePeriodic", null);

    // 첫 실행 가이드 확인
    SharedPreferences.getInstance().then((prefs) {
      isFirst = prefs.getBool('firstGuide') ?? true;
      if (isFirst) {
        setState(() {});
      }
    });
  }

  void endTutorial() {
    isFirst = false;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("firstGuide", false);
    });
    setState(() {});
  }

  void openFilter() {
    isFilterOpen = true;
    setState(() {});
  }

  void closeFilter() {
    // if()
    isFilterOpen = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isWeatherReady = context.watch<WeatherProvider>().initWeatherFlag;
    var isCoordiReady = context.watch<CoordiProvider>().isReadyCoordiState;
    return Stack(children: [
      Container(
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
                          title: Text(_title),
                          leading: Builder(
                              builder: (context) => IconButton(
                                  icon: const Icon(SweaterIcons.bars),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  }))),
                      body: SingleChildScrollView(
                          child: Container(
                              // padding:
                              //     const EdgeInsets.symmetric(horizontal: 16.0),
                              child: isWeatherReady && isCoordiReady
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: WeatherView(
                                                forecast: context
                                                    .watch<WeatherProvider>()
                                                    .getCurrentWeather(),
                                              )),
                                          CoordiSection(
                                            openFilterDrawer: openFilter,
                                          ),
                                        ])
                                  : const Loading(height: 600))),
                      drawer: Drawer(
                          backgroundColor:
                              GlobalTheme.lightTheme.colorScheme.surface,
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                DrawerHeader(
                                    child: Text(_title,
                                        style: GlobalTheme
                                            .lightTheme.textTheme.headline4),
                                    decoration: BoxDecoration(
                                        color: GlobalTheme
                                            .lightTheme.primaryColor)),
                                ListTile(
                                    leading: Icon(SweaterIcons.map_marker_alt,
                                        color: GlobalTheme
                                            .lightTheme.colorScheme.onSurface),
                                    title: Text(
                                      "위치 관리",
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
                                      context.watch<UserProvider>().gender == 1
                                          ? SweaterIcons.mars
                                          : SweaterIcons.venus,
                                      color: context
                                                  .watch<UserProvider>()
                                                  .gender ==
                                              1
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
                            ),
                            Spacer(),
                            Link(
                              uri: Uri.parse(
                                  'https://team-naming-1-hour.github.io/sweater-app/'),
                              target: LinkTarget.blank,
                              builder:
                                  (BuildContext ctx, FollowLink? openLink) {
                                return Row(children: [
                                  TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      onPressed: openLink,
                                      child: Text(
                                        '  개인정보 처리방침',
                                        style: GlobalTheme
                                            .lightTheme.textTheme.subtitle2
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .color!
                                                    .withOpacity(0.4)),
                                      )),
                                ]);
                              },
                            ),
                          ])))))),
      isFirst
          ? Container(
              color: Colors.black.withOpacity(0.7),
            )
          : Container(),
      isFirst
          ? Center(
              child: Container(
                  height: MediaQuery.of(context).size.height - 160,
                  width: MediaQuery.of(context).size.width - 32,
                  child: FirstGuide(startPressed: endTutorial)))
          : Container()
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
