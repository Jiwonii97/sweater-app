import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/module/decide_weather_icon.dart';
import 'package:sweater/widgets/hourly_weather_section.dart';
import 'package:sweater/widgets/card_container.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/widgets/loading.dart';

import 'package:sweater/theme/sweater_icons.dart';

class WeatherView extends StatelessWidget {
  final bool isNow = true;
  final Forecast forecast;

  const WeatherView({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isWeatherReady = context.read<WeatherProvider>().initWeatherFlag;
    return Container(
        alignment: Alignment.topCenter,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              decideWeatherIcon(forecast, isNow),
              Text(
                "${forecast.temp}°",
                style: Theme.of(context).textTheme.headline3,
              ),
              const Spacer(),
              SizedBox(
                  width: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                SweaterIcons.map_marker_alt,
                                size: 14,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                  context
                                      .watch<LocationProvider>()
                                      .current
                                      .name,
                                  style: Theme.of(context).textTheme.caption),
                            ]),
                        Text(
                          "체감 온도 ${forecast.sTemp}°",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.5),
                        ),
                        Text(
                          "바람 ${forecast.windSpeed}m/s ",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ]))
            ],
          ),
          SizedBox(height: 8),
          const CardContainer(child: HourlyWeatherSection()),
        ]));
  }
}
