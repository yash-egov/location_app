import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';

import 'package:location_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:location_app/bloc/locations/locations_bloc.dart';
import 'package:location_app/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/router/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

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
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
