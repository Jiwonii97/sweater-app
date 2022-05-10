import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sweater/module/error_type.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:sweater/widgets/guide_text.dart';
import 'package:sweater/widgets/search_list.dart';
import 'package:sweater/widgets/search_bar.dart';
import 'package:sweater/module/location.dart';
import 'dart:convert';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPage();
}

class _AddLocationPage extends State<AddLocationPage> {
  bool dataLoaded = false;
  bool choose = false;
  late List<Location> locationList;
  List<Widget> searchResult = [];
  String searchInput = "";
  final _title = "위치 추가";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(SweaterIcons.arrow_left),
                onPressed: () => Navigator.pop(context))),
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          SearchBar(choose: choose, text: searchInput, search: search),
          Visibility(
              child: GuideText(
                  guideText:
                      "위치는 시/도, 구/군 까지 설정할 수 있습니다. \n입력 예시) 동작구, 울릉군, 정읍시, ..."),
              visible: searchInput.isEmpty),
          Visibility(
              child: GuideText(guideText: "검색 결과가 없습니다"),
              visible: searchResult.isEmpty && searchInput.isNotEmpty),
          FutureBuilder(
              future: loadAddress(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (!dataLoaded) {
                    locationList = snapshot.data;
                    dataLoaded = true;
                  }
                }
                //error가 발생하게 될 경우 반환하게 되는 부분
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                    ),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: searchResult,
                );
              })
        ]),
      ),
    );
  }

  Future<List<Location>> loadAddress() async {
    if (!dataLoaded) {
      // return await rootBundle.loadString('assets/saved_location.json');
      String jsonString =
          await rootBundle.loadString('assets/saved_location.json');
      List<Location> locationList = json
          .decode(jsonString)['location']
          .map<Location>((locationJson) => Location.fromJson(locationJson))
          .toList();
      return locationList;
    }
    return [];
  }

  void selectOne(Location address) {
    int resultCode = context.read<LocationProvider>().addLocation(address);
    if (resultCode == ErrorType.successCode) {
      context.read<LocationProvider>().saveAll();
      Navigator.pop(this.context);
    } else {
      if (resultCode == ErrorType.duplicationErrorCode) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ErrorType.duplicationErrorMessage),
          ),
        );
      }
    }
  }

  List<Widget> search(String searchWord) {
    searchInput = searchWord;
    if (searchInput == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("검색할 지역을 입력해주세요"),
        ),
      );
      return [];
    }
    searchResult = [];
    for (var location in locationList) {
      if (searchResult.length > 6) break;
      if (location.address.contains(searchWord)) {
        searchResult.add(SearchList(refresh: selectOne, address: location));
      }
    }
    setState(() {});
    return searchResult;
  }
}
