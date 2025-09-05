import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

abstract class TripCreateRepo {
  Future<Either<Filuar, TripModel>> createTrip(
    String startLat,
    String startLng,
    String endLat,
    String endLng,
    String date,
    int seats,
    int price,
    String? notes,
    int routeIndex,
    String paymentMethod, 
    String bookingType, 
    String communicationNumber
  );
}
