import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/module/decide_weather_icon.dart';
import 'package:sweater/components/hourly_weather_section.dart';
import 'package:sweater/components/card_container.dart';
import 'package:sweater/providers/location_info.dart';
import 'package:sweater/components/loading.dart';

import 'package:sweater/theme/sweater_icons.dart';

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
                  decideWeatherIcon(hourForecast, isNow),
                  Text(
                    "${hourForecast.getTemp}°",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const Spacer(),
                  SizedBox(
                      width: 80,
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    SweaterIcons.map_marker_alt,
                                    size: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(context.watch<Location>().currentDong,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ]),
                            Text(
                              "체감 온도 ${hourForecast.getSTemp}°",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(height: 1.5),
                            ),
                            Text(
                              "바람 ${hourForecast.getWindSpeed}m/s ",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ]))
                ],
              ),
              const CardContainer(child: HourlyWeatherSection()),
            ]))
        : const Loading();
  }
}
