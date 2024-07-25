import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';

import 'package:location_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:location_app/models/weather_details.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:location_app/show_weather.dart';

@RoutePage()
class WeatherPageScreen extends StatefulWidget {
  final String city;
  const WeatherPageScreen(this.city, {Key? key}) : super(key: key);

  @override
  State<WeatherPageScreen> createState() => _WeatherPageScreenState(city);
}

class _WeatherPageScreenState extends State<WeatherPageScreen> {
  final String city;
  _WeatherPageScreenState(this.city);

  double? latitude, longitude;
  Weatherdetails? data;
  final apikey = dotenv.env["API_KEY"];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Dio dio = Dio();

  Future<void> fetchData() async {
    // print("Fetch LL Data");
    final url = 'http://api.openweathermap.org/geo/1.0/direct';
    var currstate = context.read<CityLatLonBloc>();
    final queryParameters = {
      'q': city,
      'limit': 5,
      'appid': apikey,
    };

    try {
      final response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List && responseData.isNotEmpty) {
          currstate.add(
              CityLatLonEvent(responseData[0]['lat'], responseData[0]['lon']));

          await fetchWeatherData();
        } else {
          print("No data found for the given city.");
        }
      } else {
        throw Exception('Failed to load location data');
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future<void> fetchWeatherData() async {
    var currstate = context.read<CityLatLonBloc>();
    final url = 'http://api.openweathermap.org/data/2.5/weather';
    final queryParameters = {
      'lat': currstate.state.lat,
      'lon': currstate.state.lon,
      'appid': apikey,
    };

    try {
      final response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final responseData = (response.data);
        print('Weather Data Yash: $responseData');

        Weatherdetails currData = Weatherdetails();
        currData.weather = responseData['weather'][0]['main'];
        currData.weather_description =
            responseData['weather'][0]['description'];
        currData.temp = responseData['main']['temp'];
        currData.min_temp = responseData['main']['temp_min'];
        currData.max_temp = responseData['main']['temp_max'];
        currData.humidity = responseData['main']['humidity'];
        currData.wind_speed = responseData['wind']['speed'];
        data = currData;

        var cityWeatherState = context.read<CityWeatherBloc>();
        cityWeatherState.add(fetchCityWeatherDataEvent(currData));
        print(data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _delayedBuild() async {
      await Future.delayed(const Duration(seconds: 2));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${city} Weather Report',
          ),
        ),
        body: FutureBuilder<void>(
          future: _delayedBuild(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ShowWeather(context.read<CityWeatherBloc>().state.data);
            }
          },
        ));
  }
}
