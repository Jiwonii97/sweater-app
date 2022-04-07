import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/components/location_tile.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/pages/add_location_page.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:provider/provider.dart';
import 'package:sweater/theme/sweater_icons.dart';

class ManageLocationPage extends StatefulWidget {
  const ManageLocationPage({Key? key}) : super(key: key);

  @override
  State<ManageLocationPage> createState() => _ManageLocationPage();
}

class _ManageLocationPage extends State<ManageLocationPage> {
  bool _long_press = false;
  bool init = false;
  List<Widget> loc_list = [];
  // String select = "";
  List selects = [];
  late SharedPreferences prefs;
  final String _title = "위치 관리";

  void deleteLoc(BuildContext context, String title) {
    context.read<Location>().del_loc(title);
    // _long_press = false;
    setState(() {});
  }

  List<Widget> readLocList() {
    if (loc_list.isNotEmpty) {
      loc_list = [];
    }

    for (var location in context.watch<Location>().location) {
      loc_list.add(GestureDetector(
          onTap: () => setState(() {
                context.read<Location>().cur = location["name"];
                // select = location['name'];
                context.read<Location>().save_all();
                setState(() {});
              }),
          child: context.read<Location>().cur == location['name']
              ? CheckMenu(
                  leadingIcon: SweaterIcons.map_marker_alt,
                  title: location['name'],
                  checked: context.read<Location>().cur == location['name'],
                )
              : LocationTile(
                  onPressButton: deleteLoc,
                  title: location['name'],
                  checked: context.read<Location>().cur == location['name'],
                )));
    }

    setState(() {});
    return loc_list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            actions: [
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddLocationPage())))
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: readLocList(),
        ));
  }
}
