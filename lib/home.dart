// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_route/auto_route.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';

import 'package:location_app/bloc/locations/locations_bloc.dart';

import 'package:location_app/data/data.dart';

import 'package:location_app/my_card.dart';

import 'package:location_app/router/app_router.dart';

import 'package:location_app/weather_page.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

// fetchAndFilterCities();

    context.read<LocationsBloc>().add(filterLocationsEvent(Locations().cities));
  }

  void fetchAndFilterCities() async {
    List<String>? res = await sendPostRequest();

    if (res != null) {
      print(res);

      List<String> cities = List.from(res) ?? List.from(Locations().cities);

      context.read<LocationsBloc>().add(filterLocationsEvent(cities));
    }
  }

  Future<List<String>?> sendPostRequest() async {
    var dio = Dio();

    var url = 'https://countriesnow.space/api/v0.1/countries/cities';

    var data = {"country": "India"};

    try {
      Response response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        print('POST request was successful: ${response.data}');

        List<String> cities =
            List<String>.from(response.data['data']).sublist(0, 100);

        return cities;
      } else {
        print('Failed to send POST request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while sending POST request: $e');
    }

    return null;
  }

  void _filterLocations(String query) {
    print(query);

    if (query.isEmpty) {
      context
          .read<LocationsBloc>()
          .add(filterLocationsEvent(List.from(Locations().cities)));
    } else {
      List<String> filtered = Locations()
          .cities
          .where((location) =>
              location.toLowerCase().contains(query.toLowerCase()))
          .toList();

      print(filtered);

      context.read<LocationsBloc>().add(filterLocationsEvent(filtered));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: BlocBuilder<CityLatLonBloc, CityLatLonState>(
        builder: (context, state) {
          return BlocBuilder<LocationsBloc, LocationsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
// color: Color.fromARGB(255, 86, 2, 255),

                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Search Location',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => _filterLocations(value),
                        ),
                        children: state.allCities
                            .map((city) => Center(
                                  child: ListTile(
                                    onTap: () {
                                      AutoRouter.of(context)
                                          .push(WeatherPageRoute(city: city));
                                    },
                                    title: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 234, 0),
                                                Color.fromARGB(
                                                    255, 232, 222, 121)
                                              ])),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '$city',
                                              style: TextStyle(

// color: Colors.purple,

                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
