import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sweater/providers/location_info.dart';
import 'package:provider/provider.dart';
import 'package:sweater/widgets/searched_list.dart';
import 'package:sweater/widgets/search_bar.dart';
import 'dart:convert';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPage();
}

class _AddLocationPage extends State<AddLocationPage> {
  bool dataLoaded = false;
  bool choose = false;
  late Map searchList;
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
                future: loadAddress(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (!dataLoaded) {
                      initOutput("");
                      searchList = json.decode(snapshot.data);
                      dataLoaded = true;
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

  Future loadAddress() async {
    if (!dataLoaded) {
      return await rootBundle.loadString('assets/saved_location.json');
    }
    return 1;
  }

  void selectOne(address) {
    select = {"name": address['주소'], "X": address['X'], "Y": address['Y']};
    context.read<Location>().location = [select];
    context.read<Location>().saveAll();
    Navigator.pop(this.context);
  }

  void initOutput(String text) {
    output = [SearchBar(choose: choose, text: text, search: search)];
  }

  List<Widget> search(String searchWord) {
    initOutput(searchWord);
    for (var address in searchList['location']) {
      if (output.length > 6) break;
      if (address['주소'].contains(searchWord)) {
        output.add(SearchList(refresh: selectOne, address: address));
      }
    }
    setState(() {});
    return output;
  }
}
