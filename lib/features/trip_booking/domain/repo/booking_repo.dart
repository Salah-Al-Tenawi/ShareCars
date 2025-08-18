import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';

abstract class BookingRepo {
  Future<Either<Filuar, RequestBookingModel>> booking(int seats , int tripId);
}
