import 'package:flutter/material.dart';
import 'package:sweater/components/hourly_weather_card.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';

List<HourForecast> weatherPrediction = []; //시간별 날씨 상태 담을 리스트
List<HourForecast> dummy = [
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
  HourForecast(),
];

class HourlyWeatherSection extends StatelessWidget {
  const HourlyWeatherSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 1.0),
        height: 90.0,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              dummy.length,
              (index) => HourlyWeatherCard(hourForecast: dummy[index]),
            )));
  }
}
