import 'package:flutter/material.dart';
import 'package:sweater/components/home_app_bar.dart';
import 'package:sweater/components/card_container.dart';
import 'package:sweater/pages/gender_change_page.dart';
import 'package:sweater/pages/manage_location_page.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/user_info.dart';
import '../components/coordi_section.dart';
import '../components/weather_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = "SWEATER";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<CoordiProvider>().initCoordiList();
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background-sky.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: HomeAppBar(
                title: widget.title, leading: const Icon(Icons.menu)),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    CardContainer(
                      child: WeatherView(child: Text("what1")),
                    ),
                    CardContainer(child: CoordiSection()),
                  ]),
            ),
            drawer: Drawer(
                child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                    child: Text(
                      'SWEATER',
                      style: TextStyle(fontSize: 36),
                    ),
                    decoration: BoxDecoration(color: Colors.blue)),
                ListTile(
                    leading: Icon(
                      context.watch<User>().gender == 1
                          ? Icons.man
                          : Icons.woman,
                      color: context.watch<User>().gender == 1
                          ? Colors.blue
                          : Colors.red,
                    ),
                    title: const Text("지역 관리"),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ManageLocationPage()))
                        }),
                ListTile(
                    leading: const Icon(Icons.wc),
                    title: const Text("성별 설정"),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GenderChangePage()))
                        })
              ],
            ))));
  }
}
