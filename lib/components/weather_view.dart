import 'package:flutter/material.dart';
import 'dart:math';

class WeatherView extends StatelessWidget {
  String weather;
  int temp, wind;

  WeatherView({
    Key? key,
    this.temp = 17, // °C
    this.wind = 5, // m/s
    this.weather = "맑음", // 맑음, 흐림 등등
  }) : super(key: key);

  int calc_sensible(int temp, int wind_speed) {
    wind_speed = (wind_speed * 60 * 60) ~/ 1000;
    return (13.12 +
            0.6215 * temp -
            11.37 * pow(wind_speed, 0.16) +
            0.3965 * pow(wind_speed, 0.16) * temp)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Image(
                      image: AssetImage(WeatherImage.get_image(weather)),
                      width: 60,
                      height: 60,
                      fit: BoxFit.fill)),
              SizedBox(
                width: 80,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$temp°",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30, color: Colors.white,
                            // fontFamily: 'Binggre',
                            // fontWeight: FontWeight.w700
                          )),
                      Text("체감온도 ${calc_sensible(temp, wind)}°",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10, color: Colors.white.withOpacity(0.7),
                            // fontFamily: 'Binggre',
                            // fontWeight: FontWeight.w700
                          )),
                      Text("바람 ${wind}m/s",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10, color: Colors.white.withOpacity(0.7),
                            // fontFamily: 'Binggre',
                            // fontWeight: FontWeight.w700
                          ))
                    ]),
              )
            ],
          ),
          Container() // 여기에 시간별 날씨 넣으면 됨
        ]));
  }
}

class WeatherImage {
  static Map _weather = {
    "맑음": "assets/weather/sunny.jpg",
  };

  static get_image(String now) {
    return _weather[now];
  }
}
