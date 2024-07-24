import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:location_app/router/app_router.dart';
import 'package:location_app/weather_page.dart';

class MyCard extends StatefulWidget {
  final String city;
  const MyCard(this.city, {super.key});

  @override
  State<MyCard> createState() => _MyCardState(city);
}

class _MyCardState extends State<MyCard> {
  final String city;
  _MyCardState(this.city);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        tileColor: Colors.grey,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => WeatherPageScreen(city)),
          // );
          AutoRouter.of(context).push(WeatherPageRoute(city: city));
        },
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Icon(Icons.location_city),
          Text('$city'),
        ]),
      ),
    );
  }
}
