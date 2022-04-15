import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';

class Coordi {
  String _url;
  // List<Cloth> _clothes;
  List<dynamic> _items;

  Coordi(this._url, this._items);

  String get url => _url;
  List<dynamic> get items => _items;

  List<String> getCoordiInfo() {
    List<String> result = [];

    return ['흰 크롭 반팔티'];
  }
}

class Cloth {
  // String _mainCategory;
  // String _subCategory;
  String _category;
  String _color;
  List<dynamic> _features;

  // Cloth(this._mainCategory, this._subCategory, this._color, this._features);
  Cloth(this._category, this._color, this._features);

  String get category => _category;
  String get color => _color;
  List<dynamic> get features => _features;

  Cloth.fromJson(Map<String, dynamic> json)
      : _category = json['category'],
        _color = json['color'],
        _features = json['features'];

  String getClothInfo() {
    // String color = convertColorEngToKor(this.color);
    // String features = convertFeaturesEngtoKor(this.features);
    // String category = convertCategoryEngtoKor(this.category);
    // String result = color + " " + features + " " + category;
    String features = "";
    if (this.features != null)
      for (int i = 0; i < this.features.length; i++)
        features += (this.features[i] + " ");
    String result = this.color + " " + features + " " + this.category;
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
