import 'package:flutter/material.dart';
import 'package:sweater/components/go_back_app_bar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sweater/components/rw_data.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPage();
}

class _AddLocationPage extends State<AddLocationPage> {
  late RWData helper = RWData();
  final TextEditingController text_controller = TextEditingController();
  bool data_loaded = false;
  bool choose = false;
  late Map search_list;
  var my_location;
  List<Widget> output = [];
  late Padding text;
  var select;

  @override
  void initState() {
    helper.init().then(
      (value) {
        String list = helper.read_data('my_location') ?? "";
        if (list != "") {
          my_location = json.decode(list);
        } else {
          my_location = {"selected": "", "location": []};
        }
      },
    );
    super.initState();
  }

  @override
  void disposs() {
    text_controller.dispose();
    super.dispose();
  }

  Future test() async {
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

  List<Widget> search() {
    output = [search_textfield()];
    for (var a in search_list['location']) {
      if (output.length > 6) break;
      if (a['주소'].contains(text_controller.text)) {
        TextField temp = TextField(
            controller: TextEditingController(text: a['주소']),
            readOnly: true,
            autofocus: false,
            onTap: () {
              select = {"name": a['주소'], "X": a['X'], "Y": a['Y']};
              choose = true;
              text_controller.text = a['주소'];
              output = [search_textfield()];
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(20.0),
              filled: false,
              border: InputBorder.none,
            ));
        output.add(temp);
      }
    }
    setState(() {});
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () {
        //   FocusScope.of(context).unfocus();
        // },
        child: Scaffold(
            appBar: const GoBackAppBar(
              title: '위치 추가',
            ),
            resizeToAvoidBottomInset: false,
            body: FutureBuilder(
                future: test(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (!data_loaded) {
                      text = search_textfield();
                      output = [text];
                      search_list = json.decode(snapshot.data);
                      // print(search_list['location']);
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

  Padding search_textfield() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextField(
          controller: text_controller,
          onTap: choose
              ? () => FocusManager.instance.primaryFocus?.unfocus()
              : () {},
          autofocus: false,
          showCursor: choose ? false : true,
          decoration: InputDecoration(
            prefixIcon: choose
                ? const Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                  )
                : null,
            contentPadding: const EdgeInsets.all(20.0),
            filled: true,
            // border: InputBorder.none,
            suffixIcon: choose
                ? TextButton(
                    onPressed: () => save_new_loc(),
                    child: const Text("확인"),
                  )
                : IconButton(
                    onPressed: search,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
            hintText: '주소를 입력해 주세요',
            fillColor: const Color.fromARGB(255, 232, 239, 243),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
          ),
        ));
  }
}
