import 'package:flutter/material.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget decideWeatherIcon(Forecast forecast, bool isNow) {
  bool isNight = true;
  int hour = forecast.time.hour;
  if (6 <= hour && hour <= 18) {
    isNight = false;
  }
  switch (forecast.sky) {
    case "맑음":
      return SvgPicture.asset(
          isNight ? "assets/weather/night.svg" : "assets/weather/sunny.svg",
          width: isNow ? 80.0 : 36.0,
          height: isNow ? 80.0 : 36.0);
    case "구름많음":
      return SvgPicture.asset(
          isNight
              ? "assets/weather/cloudyNight.svg"
              : "assets/weather/cloudy.svg",
          width: isNow ? 80.0 : 36.0,
          height: isNow ? 80.0 : 36.0);
    case "흐림":
      return SvgPicture.asset("assets/weather/mostlyCloudy.svg",
          width: isNow ? 80.0 : 36.0, height: isNow ? 80.0 : 36.0);
    case "비":
      return SvgPicture.asset("assets/weather/rainy.svg",
          width: isNow ? 80.0 : 36.0, height: isNow ? 80.0 : 36.0);
    case "비/눈":
      return SvgPicture.asset("assets/weather/rainAndSnow.svg",
          width: isNow ? 80.0 : 36.0, height: isNow ? 80.0 : 36.0);
    case "눈":
      return SvgPicture.asset("assets/weather/snow.svg",
          width: isNow ? 80.0 : 36.0, height: isNow ? 80.0 : 36.0);
    case "소나기":
      return SvgPicture.asset("assets/weather/shower.svg",
          width: isNow ? 80.0 : 36.0, height: isNow ? 80.0 : 36.0);
    default:
      break;
  }
  return Text("");
}
