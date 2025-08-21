import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

abstract class BookingRepo {
  Future<Either<Filuar, TripModel>> booking(int seats , int tripId);
}
