import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:sharecars/core/errors/excptions.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/maps/data/data_source/maps_data_source.dart';
import 'package:sharecars/features/maps/data/model/map_info_model.dart';

class MapRepoIm {
  final MapsDataSource mapsDataSource;

  MapRepoIm({required this.mapsDataSource});
  Future<Either<Filuar, List<RouteModel>>> fetchRouteBYOpenRouteServices (
      LatLng startLocation, LatLng endLocation) async {
    try {
      final response = await mapsDataSource.fetchRouteBYOpenRouteServices(
          startLocation, endLocation);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  } 
Future<Either<Filuar, List<RouteModel>>> fetchRouteBYgraphHopper(
      LatLng startLocation, LatLng endLocation) async {
    try {
      final response = await mapsDataSource.fetchRouteBYgraphHopper(
          startLocation, endLocation);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } 
  } 

  Future<Either<Filuar, String>> getPlaceName(LatLng location) async {
    try {
      final name = await mapsDataSource.getPlaceName(location);
      return right(name);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }
}

