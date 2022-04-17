import 'package:flutter/material.dart';
import 'package:sweater/components/hourly_weather_card.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HourlyWeatherSection extends StatefulWidget {
  const HourlyWeatherSection({Key? key}) : super(key: key);

  @override
  State<HourlyWeatherSection> createState() => _HourlyWeatherSection();
}

class _HourlyWeatherSection extends State<HourlyWeatherSection> {
  int selectedTime = -1;
  @override
  Widget build(BuildContext context) {
    var _weatherProvider = Provider.of<Weather>(context);

    List<HourForecast> weatherPrediction =
        _weatherProvider.forecastList; //시간별 날씨 상태 담을 리스트
    List<bool> selectedCheckList =
        List.generate(weatherPrediction.length - 1, (index) => false);
    return Container(
        height: 132.0,
        child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  weatherPrediction.length - 1,
                  (index) => HourlyWeatherCard(
                      hourForecast: weatherPrediction[index + 1],
                      isSelected: selectedTime == index,
                      onPress: () {
                        if (selectedTime == index) {
                          selectedTime = -1;
                          HourForecast currentForecast = weatherPrediction[0];
                          // context.read<CoordiManager>().initCoordi(currentForecast.stemp,context.watch<User>().gender,currentForecast.isRain,currentForecast.isSnow,currentForecast.windSpeed);
                          //CoordiManager에서 현재 어떤 코디를 보여주고 있는지 string 을 바꿔주는 함수 호출
                        } else {
                          selectedTime = index;
                          HourForecast selectedForecast =
                              weatherPrediction[index];
                          // context.read<CoordiManager>().initCoordi(selectedForecast.stemp,context.watch<User>().gender,selectedForecast.isRain,selectedForecast.isSnow,selectedForecast.windSpeed);
                          //CoordiManager에서 현재 어떤 코디를 보여주고 있는지 string 을 바꿔주는 함수 호출
                        }
                        setState(() {});
                      }),
                ))));
  }
}
