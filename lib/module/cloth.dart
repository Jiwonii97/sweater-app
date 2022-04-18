class Coordi {
  final String _url;
  // List<Cloth> _clothes;
  final List<dynamic> _clothes;
  final List<int> _temperature;
  final int _gender;

  Coordi(this._url, this._clothes, this._temperature, this._gender);

  String get url => _url;
  List<dynamic> get clothes => _clothes;
  List<int> get temperature => _temperature;
  int get gender => _gender;

  // List<String> getCoordiInfo() {
  //   List<String> result = [];

  //   return result;
  // }

  List<String> getIllustUrl() {
    List<String> result = []; //[아우터, 상의, 하의] 순으로 일러스트 주소 저장
    if (clothes.length == 3) {
      //아우터 있는 코디
      result.add("assets/weather/sunny.svg");
    } else {
      //아우터 없는 코디
      result.add("");
    }
    result.add("assets/weather/sunny.svg"); //상의
    result.add("assets/weather/sunny.svg"); //하의

    return result;
  }
}

class Cloth {
  final String _majorCategory;
  final String _minorCategory;
  final String _color;
  final List<dynamic> _features;
  final String _thickness;

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
    String result = "";

    String translatedColor = convertColorEngToKor(color);
    String translatedFeatures =
        features != null ? convertFeaturesEngtoKor(features) : "";

    String translatedThickness = convertThicknessEngtoKor(thickness);
    String translatedCategory = convertCategoryEngtoKor(minorCategory);
    if (majorCategory != "outer") {
      result = translatedColor +
          translatedFeatures +
          translatedThickness +
          translatedCategory;
    } else {
      result = translatedColor + translatedThickness + translatedCategory;
    }
    return result;
  }
}

String convertCategoryEngtoKor(String? input) {
  if (input == null) return '';
  switch (input) {
    case "jogger_pants":
      return '조거팬츠';
    case "leggins":
      return '레깅스';
    case "sleeve":
      return '티셔츠';
    case "one_piece":
      return '원피스';
    case "padding":
      return '패딩';
    case "mtm":
      return '맨투맨';
    case "skirt":
      return '스커트';
    case "leather_jacket":
      return '가죽자켓';
    case "moose_leather_jacket":
      return '무스탕';
    case "padding_vest":
      return '패딩 조끼';
    case "vest":
      return '니트 조끼';
    case "sweater":
      return '스웨터';
    case "shirts":
      return '셔츠';
    case "safari_jacket":
      return '야상';
    case "pants":
      return '바지';
    case "slacks":
      return '슬랙스';
    case "coat":
      return '코트';
    case "blue_jacket":
      return '청자켓';
    case "blouse":
      return '블라우스';
    case "anorak_jacket":
      return '아노락자켓';
    case "airline_jumper":
      return '항공점퍼';
    case "blouson":
      return '블루종';
    case "cardigan":
      return '가디건';
    case "coach_jacket":
      return '코치자켓';
    case "blazer":
      return '블레이저';
    case "baseball_jacket":
      return '야구잠바';
    case "hood_zipup":
      return '후드집업';
    case "fur":
      return '퍼 코트';
    case "fleese":
      return '플리스';
    case "cotton_pants":
      return '면바지';
    case "jeans":
      return '청바지';
    case "jersey":
      return '저지';
    case "training_bottom":
      return '츄리닝 바지';
    default:
      return input;
  }
}

String convertFeaturesEngtoKor(List<dynamic> input) {
  String features = "";
  for (int i = 0; i < input.length; i++)
    features += (translateFeatureEngtoKor(input[i]));
  return features;
}

String translateFeatureEngtoKor(String? input) {
  if (input == null) return '';
  switch (input) {
    case "normal":
      return '';
    case "long":
      return '긴 ';
    case "short":
      return '짧은 ';
    case "sleeveless":
      return '민소매 ';
    case "crop":
      return '크롭 ';
    case "collar":
      return '카라 ';
    case "hood":
      return '후드 ';
    case "hot":
      return '핫 ';
    case "mini":
      return '미니 ';
    case "midi":
      return '미디 ';
    default:
      return input;
  }
}

String convertThicknessEngtoKor(String? input) {
  if (input == null) return '';
  switch (input) {
    case 'thick':
      return '두꺼운 ';
    case 'thin':
      return '얇은 ';
    default:
      return input;
  }
}

String convertColorEngToKor(String? input) {
  if (input == null) return '';
  switch (input) {
    case 'white':
      return '흰색 ';
    case 'light_grey':
      return '연회색';
    case 'grey':
      return '회색 ';
    case 'gray':
      return '회색 ';
    case 'dark_grey':
      return '다크그레이색 ';
    case 'black':
      return '검정색 ';
    case 'deep_red':
      return '딥레드색 ';
    case 'red':
      return '빨간색 ';
    case 'pink':
      return '분홍색 ';
    case 'peach':
      return '연분홍색 ';
    case 'burgundy':
      return '버건디색 ';
    case 'coral':
      return '코랄색 ';
    case 'orange':
      return '오렌지색 ';
    case 'ivory':
      return '아이보리색 ';
    case 'yellow':
      return '노란색 ';
    case 'mustard':
      return '머스타드색 ';
    case 'neon_green':
      return '네온그린색 ';
    case 'light_green':
      return '연초록색 ';
    case 'mint':
      return '민트색 ';
    case 'green':
      return '초록색 ';
    case 'olive_green':
      return '올리브색 ';
    case 'khaki':
      return '카키색 ';
    case 'dark_green':
      return '어두운 초록색 ';
    case 'sky_blue':
      return '하늘색 ';
    case 'blue':
      return '파란색 ';
    case 'navy':
      return '남색 ';
    case 'lavender':
      return '연보라색 ';
    case 'violet':
      return '보라색 ';
    case 'brown':
      return '갈색 ';
    case 'red_brown':
      return '레드브라운색 ';
    case 'khaki_beige':
      return '카키베이지색 ';
    case 'camel':
      return '카멜색 ';
    case 'sand':
      return '모래색 ';
    case 'beige':
      return '베이지색 ';
    case 'yeon_chung':
      return '연청색 ';
    case 'joong_chung':
      return '중청색 ';
    case 'jin_chung':
      return '진청색 ';
    case 'heuk_chung':
      return '흑청색 ';
    default:
      return input;
  }
}
