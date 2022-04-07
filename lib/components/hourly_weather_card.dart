import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sweater/providers/weather.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({Key? key, required this.hourForecast})
      : super(key: key);

  final HourForecast hourForecast;

  Widget decideWeatherIcon() {
    switch (hourForecast.getSky) {
      case "맑음":
        return Image(
          image: new AssetImage("./assets/weather/sunny.png"),
          width: 30.0,
          height: 30.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "구름많음":
        return Image(
          image: new AssetImage("./assets/weather/cloudy.png"),
          width: 30.0,
          height: 30.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "흐림":
        return Image(
          image: new AssetImage("./assets/weather/mostly_cloudy.png"),
          width: 30.0,
          height: 30.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "비":
        return Image(
          image: new AssetImage("./assets/weather/rain.png"),
          width: 30.0,
          height: 30.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "비/눈":
        return Icon(
          Icons.cloudy_snowing,
          color: Colors.white,
        );
      case "눈":
        return Icon(
          Icons.cloudy_snowing,
          color: Colors.white,
        );
      case "소나기":
        return Icon(
          Icons.cloudy_snowing,
          color: Colors.white,
        );
      default:
        break;
    }
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90.0,
        child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 24.0,
                    sigmaY: 24.0,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView(
                        children: [
                          Center(
                            child: Text(hourForecast.getTime),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: decideWeatherIcon()),
                              Column(
                                children: [
                                  Text("${hourForecast.getTemp}'c"),
                                  Text("${hourForecast.getRainRate} %"),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ))));
  }
}
