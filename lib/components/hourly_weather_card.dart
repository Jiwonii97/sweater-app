import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/module/decide_weather_icon.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({Key? key, required this.hourForecast})
      : super(key: key);

  final HourForecast hourForecast;

  @override
  Widget build(BuildContext context) {
    bool isNow = false;
    return Container(
        width: 88.0,
        child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 24.0,
                    sigmaY: 24.0,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: ListView(
                        children: [
                          Center(
                            child: Text(hourForecast.getTime,
                                style: TextStyle(fontSize: 12)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              decideWeatherIcon(hourForecast, isNow),
                              Column(
                                children: [
                                  Text("${hourForecast.getTemp}°",
                                      style: TextStyle(fontSize: 20)),
                                  Text("${hourForecast.getRainRate} %",
                                      style: TextStyle(fontSize: 12)),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ))));
  }
}
