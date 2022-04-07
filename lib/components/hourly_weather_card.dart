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
          width: 40.0,
          height: 40.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "구름많음":
        return Image(
          image: new AssetImage("./assets/weather/cloudy.png"),
          width: 40.0,
          height: 40.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "흐림":
        return Image(
          image: new AssetImage("./assets/weather/mostly_cloudy.png"),
          width: 40.0,
          height: 40.0,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        );
      case "비":
        return Image(
          image: new AssetImage("./assets/weather/rain.png"),
          width: 40.0,
          height: 40.0,
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
                            child: Text(hourForecast.getTime,
                                style: TextStyle(fontSize: 12)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              decideWeatherIcon(),
                              Column(
                                children: [
                                  Text("${hourForecast.getTemp}°",
                                      style: TextStyle(fontSize: 20)),
                                  Text("${hourForecast.getRainRate} %",
                                      style: TextStyle(fontSize: 12)),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ))));
  }
}
