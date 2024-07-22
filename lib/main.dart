import 'package:flutter/material.dart';
import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';

import 'package:location_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:location_app/bloc/locations/locations_bloc.dart';
import 'package:location_app/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationsBloc(),
        ),
        BlocProvider(
          create: (context) => CityLatLonBloc(),
        ),
        BlocProvider(
          create: (context) => CityWeatherBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
