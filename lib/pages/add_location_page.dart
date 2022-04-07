import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sweater/providers/location_info.dart';
import 'package:provider/provider.dart';
import 'package:sweater/components/searched_list.dart';
import 'package:sweater/components/search_bar.dart';
import 'dart:convert';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPage();
}

class _AddLocationPage extends State<AddLocationPage> {
  bool data_loaded = false;
  bool choose = false;
  late Map search_list;
  List<Widget> output = [];
  late Padding text;
  var select;
  final _title = "위치 추가";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            appBar: AppBar(
                title: Text(_title),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context))),
            resizeToAvoidBottomInset: false,
            body: FutureBuilder(
                future: load_address(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (!data_loaded) {
                      init_output("");
                      search_list = json.decode(snapshot.data);
                      data_loaded = true;
                    }
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: output,
                  );
                })));
  }

  Future load_address() async {
    if (!data_loaded) {
      return await rootBundle.loadString('assets/saved_location.json');
    }
    return 1;
  }

  void save_new_loc() async {
    context.read<Location>().location = [select];
    context.read<Location>().save_all();
    Navigator.pop(this.context);
  }

  void select_one(address) {
    select = {"name": address['주소'], "X": address['X'], "Y": address['Y']};
    choose = true;
    output = [
      SearchBar(
          choose: choose,
          text: address['주소'],
          search: search,
          save_loc: save_new_loc)
    ];
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {});
  }

  void init_output(String text) {
    output = [
      SearchBar(
          choose: choose, text: text, search: search, save_loc: save_new_loc)
    ];
  }

  List<Widget> search(String search_word) {
    init_output(search_word);
    for (var a in search_list['location']) {
      if (output.length > 6) break;
      if (a['주소'].contains(search_word)) {
        output.add(SearchList(refresh: select_one, address: a));
      }
    }
    setState(() {});
    return output;
  }
}
