import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

abstract class TripDetailsRepo {
  Future<Either<Filuar, TripModel>> featchTrip(int tripId);
}
