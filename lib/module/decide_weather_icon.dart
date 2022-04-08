import 'package:flutter/material.dart';
import 'package:sweater/providers/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget decideWeatherIcon(HourForecast hourForecast) {
  switch (hourForecast.getSky) {
    case "맑음":
      return SvgPicture.asset("assets/weather/sunny.svg",
          width: 40.0, height: 40.0);
    case "구름많음":
      return SvgPicture.asset("assets/weather/cloudy.svg",
          width: 40.0, height: 40.0);
    case "흐림":
      return SvgPicture.asset("assets/weather/mostlyCloudy.svg",
          width: 40.0, height: 40.0);
    case "비":
      return SvgPicture.asset("assets/weather/rainy.svg",
          width: 40.0, height: 40.0);
    case "비/눈":
      return SvgPicture.asset("assets/weather/rainAndSnow.svg",
          width: 40.0, height: 40.0);
    case "눈":
      return SvgPicture.asset("assets/weather/snow.svg",
          width: 40.0, height: 40.0);
    case "소나기":
      return SvgPicture.asset("assets/weather/shower.svg",
          width: 40.0, height: 40.0);
    default:
      break;
  }
  return Text("");
}
