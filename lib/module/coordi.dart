import 'package:sweater/module/cloth.dart';

class Coordi {
  final String _url;
  final List<Cloth> _clothes;

  Coordi(this._url, this._clothes);

  String get url => _url;
  List<Cloth> get clothes => _clothes;

  List<String> getCoordiInfo() {
    List<String> result = [];
    for (int i = 0; i < clothes.length; i++) {
      result.add(clothes[i].getClothInfo());
    }
    return result;
  }

  List<String> getIllustUrl() {
    List<String> result = []; //[아우터, 상의, 하의] 순으로 일러스트 주소 저장

    if (clothes.length == 3) {
      //아우터 있는 코디
      result.add(clothes[0].getSVGFilePath()); //아우터
      result.add(clothes[1].getSVGFilePath()); //상의
      result.add(clothes[2].getSVGFilePath()); //하의
    } else {
      //아우터 없는 코디
      result.add("");
      result.add(clothes[0].getSVGFilePath()); //상의
      result.add(clothes[1].getSVGFilePath()); //하의
    }
    return result;
  }
}
