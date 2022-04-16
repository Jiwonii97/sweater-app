import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/providers/user_info.dart';
import 'package:sweater/module/decide_weather_icon.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard(
      {Key? key, required this.hourForecast, required this.cardIdx})
      : super(key: key);

  final HourForecast hourForecast;
  final int cardIdx;

  @override
  Widget build(BuildContext context) {
    bool isNow = false;
    var coordiConsumer = Provider.of<CoordiProvider>(context);
    var weatherConsumer = Provider.of<Weather>(context);
    var userConsumer = Provider.of<User>(context);
    return GestureDetector(
        onTap: () => coordiConsumer.requestCoordiList(
            weatherConsumer.forecastList, cardIdx + 1, userConsumer.gender),
        child: SizedBox(
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
                                child: Text(
                                    hourForecast.getTime.substring(0, 2) +
                                        ":00",
                                    style: const TextStyle(fontSize: 12)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  decideWeatherIcon(hourForecast, isNow),
                                  Column(
                                    children: [
                                      Text("${hourForecast.getTemp}°",
                                          style: const TextStyle(fontSize: 20)),
                                      Text("${hourForecast.getRainRate} %",
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    )))));
  }
}
