import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';

class Coordi {
  String _url;
  // List<Cloth> _clothes;
  List<dynamic> _items;
  List<int> _temperature;
  int _gender;

  Coordi(this._url, this._items, this._temperature, this._gender);

  String get url => _url;
  List<dynamic> get items => _items;
  List<int> get temperature => _temperature;
  int get gender => _gender;

  List<String> getCoordiInfo() {
    List<String> result = [];

    return ['흰 크롭 반팔티'];
  }
}

class Cloth {
  String _majorCategory;
  String _minorCategory;
  String _color;
  List<dynamic> _features;
  String _thickness;

  Cloth(this._majorCategory, this._minorCategory, this._color, this._features,
      this._thickness);

  String get majorCategory => _majorCategory;
  String get minorCategory => _minorCategory;
  String get color => _color;
  List<dynamic> get features => _features;
  String get thickness => _thickness;

  Cloth.fromJson(Map<String, dynamic> json)
      : _majorCategory = json['major'],
        _minorCategory = json['minor'],
        _color = json['color'],
        _features = json['features'],
        _thickness = json['thickness'];

  String getClothInfo() {
    // print(this.category);
    // String color = convertColorEngToKor(this.color);
    // String features = convertFeaturesEngtoKor(this.features);
    // String category = convertCategoryEngtoKor(this.category);
    // String result = color + " " + features + " " + category;
    String features = "";
    String result = "";
    if (this.majorCategory != "outer") {
      for (int i = 0; i < this.features.length; i++)
        features += (this.features[i] + " ");
      result = this.color +
          " " +
          features +
          " " +
          this.thickness +
          " " +
          this.minorCategory;
    } else
      result = this.color + " " + this.thickness + " " + this.minorCategory;
    // return "a";
    return result;
  }
}

String convertCategoryEngtoKor(String input) {
  switch (input) {
    case "":
      return '';
  }
  //카테고리 번역해야함
  return 'Category';
}

String convertFeaturesEngtoKor(List<dynamic> input) {
  //속성 번역해야함
  String features = "";
  for (int i = 0; i < input.length; i++) features += (input[i] + " ");
  return "features";
}

String convertColorEngToKor(String input) {
  //색깔 번역해야함
  return 'Color';
}
