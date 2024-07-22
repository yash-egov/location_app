import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:location_app/models/weather_details.dart';
import 'package:meta/meta.dart';

part 'city_weather_event.dart';
part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  CityWeatherBloc() : super(CityWeatherInitial(new Weatherdetails())) {
    on<CityWeatherEvent>((event, emit) {});
    on<fetchCityWeatherDataEvent>((event, emit) {
      emit(CityWeatherState(event.data));
    });
  }
}
