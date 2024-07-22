part of 'city_lat_lon_bloc.dart';

@immutable
class CityLatLonEvent {
  double lat, lon;
  CityLatLonEvent(this.lat, this.lon);
}

class CityEvent extends CityLatLonEvent {
  String city;
  CityEvent(this.city) : super(0.0, 0.0);
}
