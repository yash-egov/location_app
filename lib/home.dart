// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/bloc/bloc/city_lat_lon_bloc.dart';
import 'package:location_app/bloc/locations/locations_bloc.dart';
import 'package:location_app/data/data.dart';
import 'package:location_app/my_card.dart';
import 'package:location_app/weather_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                                  tileColor: Colors.grey,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WeatherPage(city)),
                                    );
                                  },
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.location_city),
                                        Text('$city'),
                                      ]),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
