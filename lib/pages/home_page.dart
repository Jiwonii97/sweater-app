import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/components/home_app_bar.dart';
import 'package:sweater/components/card_container.dart';
import 'package:sweater/components/coordi_section.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/pages/gender_change_page.dart';

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
                    CardContainer(child: Text("weather_section")),
                    CardContainer(child: CoordiSection()),
                    CardContainer(child: Text("insta_link")),
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
                const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text("지역 관리"),
                ),
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
