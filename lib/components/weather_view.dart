import 'package:flutter/material.dart';
import 'package:sweater/providers/location_info.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherView extends StatelessWidget {
  String weather;
  String temp, sTemp, wind;

  WeatherView({
    Key? key,
    this.temp = "27", // °C
    this.sTemp = "99", // 체감온도
    this.wind = "99", // m/s
    this.weather = "맑음", // 맑음, 흐림 등등
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        alignment: Alignment.topCenter,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: SvgPicture.asset(WeatherImage.getImage(weather),
                    width: 80.0, height: 80.0),
              ),
              SizedBox(
                width: 80,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$temp°",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Colors.white, height: 1.1),
                      ),
                      Text(
                        "체감 온도 ${sTemp}°",
                        // textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white.withOpacity(0.7), height: 1),
                      ),
                      Text(
                        "바람 ${wind}m/s ",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: Colors.white.withOpacity(0.7)),
                      )
                    ]),
              )
            ],
          ),
          Container() // 여기에 시간별 날씨 넣으면 됨
        ]));
  }
}

class WeatherImage {
  static const Map _weather = {
    "맑음": "assets/weather/sunny.svg",
    "구름많음": "assets/weather/cloudy.svg",
    "흐림": "assets/weather/mostlyCloudy.svg",
    "비": "assets/weather/rainy.svg",
    "비/눈": "assets/weather/rainAndSnow.svg",
    "눈": "assets/weather/snow.svg",
    "소나기": "assets/weather/shower.svg",
  };

  static getImage(String now) {
    return _weather[now];
  }
}
