import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'city_lat_lon_event.dart';
part 'city_lat_lon_state.dart';

class CityLatLonBloc extends Bloc<CityLatLonEvent, CityLatLonState> {
  CityLatLonBloc() : super(CityLatLonInitial()) {
    on<CityLatLonEvent>((event, emit) {
      emit(CityLatLonState(event.lat, event.lon));
    });
    on<CityEvent>((event, emit) {});
  }
}
