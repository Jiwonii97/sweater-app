import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/components/location_app_bar.dart';
import 'package:sweater/components/rw_data.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ManageLocationPage extends StatefulWidget {
  const ManageLocationPage({Key? key}) : super(key: key);

  @override
  State<ManageLocationPage> createState() => _ManageLocationPage();
}

class _ManageLocationPage extends State<ManageLocationPage> {
  bool _long_press = false;
  bool init = false;
  List<Widget> loc_list = [];
  String select = "";
  List selects = [];
  late SharedPreferences prefs;

  List<Widget> _read_loc_list() {
    if (loc_list.length == 0) {
      select = context.read<Location>().cur;
    } else
      loc_list = [];

    for (var location in context.watch<Location>().location) {
      loc_list.add(GestureDetector(
        onTap: () => setState(() {
          context.read<Location>().cur = location["name"];
          select = location['name'];
          context.read<Location>().save_all();
          setState(() {});
        }),
        onLongPress: () => setState(() {
          _long_press = !_long_press;
          select = location['name'];
          context.read<Location>().cur = location["name"];
          setState(() {});
        }),
        child: CheckMenu(
            leadingIcon: Icons.location_on_outlined,
            title: location['name'],
            checked: select == location['name'],
            multi_select: _long_press),
      ));
    }
    if (_long_press) {
      loc_list.add(Expanded(flex: 1, child: Container()));
      loc_list.add(ButtonBar(alignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () {
              context.read<Location>().del_loc(select);
              _long_press = false;
              setState(() {});
            },
            icon: Icon(Icons.delete_forever))
      ]));
    }
    setState(() {});
    return loc_list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LocationAppBar(
          title: '위치 관리',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _read_loc_list(),
        ));
  }
}
