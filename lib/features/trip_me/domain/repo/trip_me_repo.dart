import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

abstract class TripMeRepo {
  Future<Either<Filuar, List<TripModel>>> showAllTrip();
  Future<Either<Filuar, TripModel>> showOneTrip(int tripId);
  Future<Either<Filuar, dynamic>> cancelTrip(int tripId); 
  
  
}
