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
    return _weatherProvider.initWeatherFlag
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 1.0),
            height: 76.0,
            child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      weatherPrediction.length - 1,
                      (index) => HourlyWeatherCard(
                          hourForecast: weatherPrediction[index + 1]),
                    ))))
        : Container(
            height: 76.0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color?>(Colors.blue[100]),
                backgroundColor: Colors.blue[600],
              ),
            ));
  }
}
