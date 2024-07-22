part of 'locations_bloc.dart';

@immutable
class LocationsEvent {}

class filterLocationsEvent extends LocationsEvent {
  final List<String> cities;
  filterLocationsEvent(this.cities);
}
