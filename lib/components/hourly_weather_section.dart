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

class HourlyWeatherSection extends StatelessWidget {
  const HourlyWeatherSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _weatherProvider = Provider.of<Weather>(context);
    List<HourForecast> weatherPrediction =
        _weatherProvider.forecastList; //시간별 날씨 상태 담을 리스트
    return Container(
        height: 132.0,
        child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  weatherPrediction.length - 1,
                  (index) => HourlyWeatherCard(
                      hourForecast: weatherPrediction[index + 1]),
                ))));
  }
}
