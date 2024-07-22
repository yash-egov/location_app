import 'package:flutter/material.dart';
import 'package:location_app/models/weather_details.dart';

class ShowWeather extends StatelessWidget {
  final Weatherdetails data;
  const ShowWeather(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ListTile(
          title: Text("Temperature : ${data!.temp}"),
          // titleTextStyle: ,
        ),
        ListTile(
          title: Text('Weather: ${data!.weather}'),
          // tileColor: Colors.indigo,
        ),
        ListTile(
          title: Text('Weather Description: ${data!.weather_description}'),
          // tileColor: Colors.blue,
        ),
        ListTile(
          title: Text('Temperature: ${data!.temp}'),
          // tileColor: Colors.green,
        ),
        ListTile(
          title: Text('Min Temperature: ${data!.min_temp}'),
          // tileColor: Colors.yellow,
        ),
        ListTile(
          title: Text('Max Temperature: ${data!.max_temp}'),
          // tileColor: Colors.orange,
        ),
        ListTile(
          title: Text('Humidity: ${data!.humidity}'),
          // tileColor: Colors.red,
        ),
        ListTile(
          title: Text('Wind Speed: ${data!.wind_speed}'),
          // tileColor: Colors.grey,
        ),
      ],
    );
  }
}
