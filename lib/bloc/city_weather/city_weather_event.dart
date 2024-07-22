part of 'city_weather_bloc.dart';

@immutable
class CityWeatherEvent {}

class fetchCityWeatherDataEvent extends CityWeatherEvent {
  Weatherdetails data;
  fetchCityWeatherDataEvent(this.data);
}
