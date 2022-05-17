import 'package:sweater/module/cloth.dart';

class Coordi {
  final String _url;
  final List<Cloth> _clothes;
  final String _style;

  Coordi(this._url, this._clothes, this._style);

  String get url => _url;
  List<Cloth> get clothes => _clothes;
  String get style => _style;

  List<String> getCoordiInfo() {
    List<String> result = [];
    for (int i = 0; i < clothes.length; i++) {
      result.add(clothes[i].getClothInfo());
    }
    return result;
  }

  List<String> getIllustUrl() {
    List<String> result = [];
    for (int i = 0; i < clothes.length; i++) {
      result.add(clothes[i].getPNGFilePath());
    }
    return result;
  }
}
