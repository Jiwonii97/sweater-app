import 'dart:ui';
import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  final Widget child;
  final String address, date, temp, etc, weather;
  const WeatherView(
      {Key? key,
      required this.child,
      this.address = '내곡동',
      this.date = '4월 1일 금요일 17:00',
      this.temp = "16",
      this.weather = "assets/weather/sunny.png",
      this.etc = '화창\n 16°/3°\n체감온도 15°'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
        height: 155,
        child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                  height: 38,
                  width: MediaQuery.of(context).size.width - 25,
                  child: Row(children: [
                    Icon(Icons.location_on_sharp),
                    Text(
                      '' + address,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 15,
                        // fontFamily: 'Binggre',
                        // fontWeight: FontWeight.w700
                      ),
                    )
                  ]),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(13, 0, 5, 10),
                    height: 25,
                    width: MediaQuery.of(context).size.width - 25,
                    child: Text(
                      date,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 10,
                        // fontFamily: 'Binggre',
                      ),
                    )),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                        child: Image(
                            image: AssetImage(weather),
                            width: 70,
                            height: 70,
                            fit: BoxFit.fill)),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(temp + "°c",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 40,
                              // fontFamily: 'Binggre',
                              // fontWeight: FontWeight.w700
                            ))),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(etc,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              // fontFamily: 'Binggre',
                              // fontWeight: FontWeight.w700
                            ))),
                  ],
                )
              ],
            )));
  }
}
