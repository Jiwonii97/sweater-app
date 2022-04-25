import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/module/decide_weather_icon.dart';

class HourlyWeatherCard extends StatelessWidget {
  HourlyWeatherCard(
      {Key? key,
      required this.hourForecast,
      required this.isSelected,
      required this.onPress})
      : super(key: key);

  final HourForecast hourForecast;
  bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    bool isNow = false;
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: 64.0,
        margin: const EdgeInsets.only(right: 8),
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.surface.withOpacity(0.4)
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(hourForecast.getTime.substring(0, 2) + ":00",
                    style: Theme.of(context).textTheme.caption),
                decideWeatherIcon(hourForecast, isNow),
                Text("${hourForecast.getTemp}°",
                    style: Theme.of(context).textTheme.headline6),
                Text("${hourForecast.getRainRate} %",
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
