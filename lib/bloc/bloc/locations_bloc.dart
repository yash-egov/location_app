import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc() : super(LocationsInitial()) {
    on<filterLocationsEvent>((event, emit) {
      // TODO: implement event handler
      // print("Hello inside Event file");
      // print(event.cities);
      emit(LocationsState(event.cities));
    });
  }
}
