part of 'locations_bloc.dart';

@immutable
class LocationsState {
  final List<String> allCities;
  LocationsState(this.allCities);
}

final class LocationsInitial extends LocationsState {
  LocationsInitial() : super([]);
}

class filterLocationsState extends LocationsState {
  filterLocationsState(cities) : super(cities);
}
