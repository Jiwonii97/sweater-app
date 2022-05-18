import 'package:flutter/material.dart';
import 'package:sweater/widgets/hourly_weather_card.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/providers/user_provider.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HourlyWeatherSection extends StatefulWidget {
  const HourlyWeatherSection({Key? key}) : super(key: key);

  @override
  State<HourlyWeatherSection> createState() => _HourlyWeatherSection();
}

class _HourlyWeatherSection extends State<HourlyWeatherSection> {
  int selectedTime = -1;
  @override
  Widget build(BuildContext context) {
    var _weatherProvider = context.watch<WeatherProvider>();
    var coordiConsumer = Provider.of<CoordiProvider>(context);
    var userConsumer = Provider.of<UserProvider>(context);

    List<HourForecast> weatherPrediction =
        _weatherProvider.forecastList; //시간별 날씨 상태 담을 리스트
    List<bool> selectedCheckList =
        List.generate(weatherPrediction.length - 1, (index) => false);
    return Container(
        height: 116.0,
        child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  weatherPrediction.length - 1,
                  (index) => HourlyWeatherCard(
                      hourForecast: weatherPrediction[index + 1],
                      isSelected: selectedTime == index,
                      onPress: () {
                        if (selectedTime == index) {
                          selectedTime = -1;
                          HourForecast currentForecast = weatherPrediction[0];
                          coordiConsumer.requestCoordiList(
                              _weatherProvider.getCurrentWeather(),
                              userConsumer.user);
                        } else {
                          selectedTime = index;
                          HourForecast? selectedForecast =
                              _weatherProvider.getSelectedWeather(index + 1);
                          if (selectedForecast != null) {
                            coordiConsumer.requestCoordiList(
                                selectedForecast, userConsumer.user);
                          }
                        }
                        setState(() {});
                      }),
                ))));
  }
}
