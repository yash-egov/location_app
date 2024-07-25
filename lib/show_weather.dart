import 'package:flutter/material.dart';
import 'package:location_app/models/weather_details.dart';

class ShowWeather extends StatelessWidget {
  final Weatherdetails data;
  const ShowWeather(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = 100.0;
    double boxMargin = screenWidth / 4;
    double boxMargin1 = 40;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 100,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Temperature : ${data!.temp}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Weather : ${data!.weather}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Weather Description : ${data!.weather_description}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Min Temperature : ${data!.min_temp}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Max Temperature : ${data!.max_temp}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Humidity : ${data!.humidity}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(
                boxMargin, boxMargin1, boxMargin, boxMargin1),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 94, 255),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Wind Speed: ${data!.wind_speed}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
