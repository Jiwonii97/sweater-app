import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/*
    String basedate   // 기준 날짜    ex) 19700101
    String basetime   // 기준 시간 값     ex) 1200
    String nx   // 기준 위치 X좌표    ex) 59
    String ny   // 기준 위치 Y좌표    ex) 125
    */
Future<List<dynamic>?> fetchWeather(
    int nx, int ny, DateTime now, int predictMax, String key) async {
  const String host = "apis.data.go.kr";
  const String path = "/1360000/VilageFcstInfoService_2.0/getVilageFcst";
  /*
      Q. 왜 계산을 이렇게 진행 하였는가?
      A. 우리가 날씨 정보를 구하는 단기예보의 데이터의 경우,
      날씨 정보를 업데이트 하는 Base_time이 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 총 6개로 구성되어 있다.
      그래서 현재 날씨 정보를 얻으려면 가장 가깝게 업데이트 된 날씨 정보 데이터를 얻어와야 하므로 추가적인 연산을 진행하게 된다
      - 계산 과정 : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 -> 0000, 0300, 0600, 0900, 1200, 1500, 1800, 2100으로 우선 바꾼다
        3으로 나눠 원하는 시간대가 언제인지 구한다 -> 원래 baseTime으로 돌리기 위해 연산을 역으로 진행하기 위해 (*3)+2를 수행한다
      ex) 현재시간 : 1300 -> 13 -> 11-> ~/3 몫 : 3 -> 3*3+2 = 11 -> 1100의 날씨 정보를 받아오면 된다
          따라서 우리가 날씨 정보를 얻기위해 가져올 최신 날씨 정보는 1100 시간의 날씨 정보이다
    */
  // 만약 현재시간이 2시 이전이라면 BaseTime은 전날에 2300이므로 시간과 더불어 날짜도 하루전으로 바꿔야 한다
  DateTime anHourBefore = now.subtract(
      const Duration(hours: 1)); // 현재 시간(now) 기준, 1시간전 시간(anHourBefore) 구하기
  DateTime requestTime =
      anHourBefore.subtract(Duration(hours: ((anHourBefore.hour + 22) % 3)));
  try {
    // url 변환
    final url = Uri.https(host, path, {
      "serviceKey": key,
      "pageNo": "1",
      "numOfRows": ((predictMax + 2) * 12)
          .toString(), // 원래 구하는 시간을 기준보다 +2를 하여 BaseTime에 묶여 있는 3시간의 값을 불러와 원하는 시간대의 12시간 데이터를 뽑아내려고 함
      "dataType": "JSON",
      "base_date": DateFormat("yyyyMMdd").format(requestTime),
      "base_time": DateFormat("HH30").format(
          requestTime), // 30분으로 시간을 설정한 이유 : API 제공 시간(~이후)이 각 BaseTime +10분이기 때문이다
      "nx": nx.toString(),
      "ny": ny.toString()
    });
    final response = await http.get(url); // http 호출
    // http 호출이 안되면 예외 처리
    if (response.statusCode != 200) {
      throw HttpException('${response.statusCode}');
    }
    List<dynamic> data =
        convert.jsonDecode(response.body)['response']['body']['items']['item'];
    final List tempList = data.where((el) => el['category'] == 'TMP').toList();
    final List skyList = data.where((el) => el['category'] == 'SKY').toList();
    final List rainList = data.where((el) => el['category'] == 'PTY').toList();
    final List rainRateList =
        data.where((el) => el['category'] == 'POP').toList();
    final List windSpeedList =
        data.where((el) => el['category'] == 'WSD').toList();
    final List dateList = windSpeedList.map((el) => el['fcstDate']).toList();
    final List timeList = windSpeedList.map((el) => el['fcstTime']).toList();
    List<Map<String, dynamic>> forecastDataList = [];
    for (int i = 0; i < predictMax + 2; i++) {
      String year = dateList[i].substring(0, 4);
      String month = dateList[i].substring(4, 6);
      String date = dateList[i].substring(6, 8);
      String hour = timeList[i].substring(0, 2);
      String minute = timeList[i].substring(2, 4);
      String second = '00';
      forecastDataList.add({
        "date": DateFormat("yyyy-MM-dd HH:mm:ss").parse(year +
            '-' +
            month +
            '-' +
            date +
            ' ' +
            hour +
            ':' +
            minute +
            ':' +
            second),
        "temp": int.parse(tempList[i]['fcstValue']),
        "sky": skyList[i]['fcstValue'],
        "rain": rainList[i]['fcstValue'],
        "rainRate": int.parse(rainList[i]['fcstValue']),
        "windSpeed": double.parse(windSpeedList[i]['fcstValue']),
      });
    }
    int sub = (anHourBefore.hour + 22) % 3; // ex) 23시 -> 0, 0시 -> 1, 1시 -> 2
    return forecastDataList.sublist(sub, predictMax + sub);
  } on SocketException {
    print('No Internet connection 😑');
    return null;
  } on HttpException {
    print("Couldn't find the post 😱");
    return null;
  } on FormatException {
    print("Bad response format 👎");
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}
