import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/module/decide_weather_icon.dart';
import 'package:sweater/components/hourly_weather_section.dart';

class WeatherView extends StatelessWidget {
  final bool isNow = true;
  final HourForecast hourForecast;

  const WeatherView({Key? key, required this.hourForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isWeatherReady = context.read<Weather>().initWeatherFlag;
    return isWeatherReady
        ? Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            alignment: Alignment.topCenter,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: decideWeatherIcon(hourForecast, isNow)),
                  SizedBox(
                    width: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${hourForecast.getTemp}°",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: Colors.white, height: 1.1),
                          ),
                          Text(
                            "체감 온도 ${hourForecast.getSTemp}°",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                    height: 1),
                          ),
                          Text(
                            "바람 ${hourForecast.getWindSpeed}m/s ",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.7)),
                          )
                        ]),
                  )
                ],
              ),
              const HourlyWeatherSection(),
            ]))
        : SizedBox(
            height: 180.0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[100]),
                backgroundColor: Colors.blue[600],
              ),
            ));
  }
}
