part of 'city_weather_bloc.dart';

@immutable
class CityWeatherState {
  Weatherdetails data;
  CityWeatherState(this.data);
}

final class CityWeatherInitial extends CityWeatherState {
  CityWeatherInitial(data) : super(data);
}
