import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Cloth {
  final String _majorCategory;
  final String _minorCategory;
  final String _color;
  final String _fullName;

  Cloth(this._majorCategory, this._minorCategory, this._color, this._fullName);

  String get majorCategory => _majorCategory;
  String get minorCategory => _minorCategory;
  String get color => _color;
  String get fullName => _fullName;

  Cloth.fromJson(Map<String, dynamic> json)
      : _majorCategory = json['major'],
        _minorCategory = json['minor'],
        _color = json['color'],
        _fullName = json['full_name'];

  String getSVGFilePath() {
    String path = "assets/cloth/";
    switch (majorCategory) {
      case "outer":
        path += "outer/";
        break;
      case "top":
        path += "top/";
        break;
      case "bottom":
        path += "bottom/";
        break;
      case "one_piece":
        path += "one_piece/";
        break;
      default:
        break;
    }
    path += "$minorCategory.svg";
    return path;
  }

  String getClothInfo() {
    return fullName;
  }
}
