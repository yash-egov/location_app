part of 'city_lat_lon_bloc.dart';

@immutable
class CityLatLonState {
  double lat, lon;
  CityLatLonState(this.lat, this.lon);
}

final class CityLatLonInitial extends CityLatLonState {
  CityLatLonInitial() : super(0.00, 0.00);
}
