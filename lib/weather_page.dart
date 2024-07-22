import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';

import 'package:location_app/bloc/city_weather/city_weather_bloc.dart';
import 'package:location_app/models/weather_details.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:location_app/show_weather.dart';

class WeatherPage extends StatefulWidget {
  final String city;
  const WeatherPage(this.city, {Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState(city);
}

class _WeatherPageState extends State<WeatherPage> {
  final String city;
  _WeatherPageState(this.city);

  double? latitude, longitude;
  Weatherdetails? data;
  String apikey = '607b7b345825d6708789aa153c57a28a';

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
          // setState(() {
          //   latitude = responseData[0]['lat'];
          //   longitude = responseData[0]['lon'];
          // });
          currstate.add(
              CityLatLonEvent(responseData[0]['lat'], responseData[0]['lon']));
          // print("Fetch LL Data success");

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
    // print("Fetch W Data ");
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

        // setState(() {
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
        // });
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
    return (context.read<CityWeatherBloc>().state.data == null)
        ? Scaffold(
            appBar: AppBar(
              title: Text("Loading..."),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                '${city} Weather Report',
              ),
            ),
            body: ShowWeather(context.read<CityWeatherBloc>().state.data),
          );
  }
}
