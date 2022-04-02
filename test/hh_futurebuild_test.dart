import 'package:flutter/material.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/components/location_app_bar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sweater/components/rw_data.dart';
import 'dart:convert';

class ManageLocationPage extends StatefulWidget {
  const ManageLocationPage({Key? key}) : super(key: key);

  @override
  State<ManageLocationPage> createState() => _ManageLocationPage();
}

class _ManageLocationPage extends State<ManageLocationPage> {
  String? _selected;
  bool _long_press = false;
  bool initialized = false;
  var location_list;
  // late ScrollController _scrollController;

  Future<String> _read_loc_list() async {
    return await rootBundle.loadString('assets/saved_location.json');
  }

  void _write_loc_list() {}

  @override
  void dispose() {
    // _scrollController.dispose();
    _write_loc_list();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _read_loc_list(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> loc_list = [
                const LocationAppBar(
                  title: '위치 관리',
                )
              ];

              if (snapshot.hasData) {
                location_list = json.decode(snapshot.data);

                if (!initialized) {
                  _selected = location_list['selected'];
                  initialized = true;
                }

                for (var location in location_list['location']) {
                  loc_list.add(GestureDetector(
                    onTap: () => setState(() {
                      _selected = location['name'];
                    }),
                    onLongPress: () => setState(() {
                      _long_press = !_long_press;
                    }),
                    child: CheckMenu(
                        leadingIcon: Icons.location_on_outlined,
                        title: location['name'],
                        checked: _selected == location['name'],
                        multi_select: _long_press),
                  ));
                }
              }
              //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
              else if (snapshot.hasData == false) {
                loc_list = [
                  CircularProgressIndicator()
                ]; // CircularProgressIndicator : 로딩 에니메이션
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loc_list,
              );
            }));
  }
}
