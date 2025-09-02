import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/excptions.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_booking/data/data%20source/booking_remote_data_source.dart';
import 'package:sharecars/features/trip_booking/data/model/booking_me_model.dart';

class BookingMeRepo {
  final BookingRemoteDataSource _remoteDataSource;

  BookingMeRepo({required BookingRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  Future<Either<Filuar, List<BookingMe>>> getMeBooking() async {
    try {
      final bookings = await _remoteDataSource.getMeBooking();
      return Right(bookings);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }

// todo Modeling
  Future<Either<Filuar, dynamic>> cancelBooking(
      int bookingId, int seats) async {
    try {
      final response = await _remoteDataSource.cancelBooking(bookingId, seats);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }

  Future<Either<Filuar, dynamic>> finshTrip(int tripId) async {
    try {
      final response = await _remoteDataSource.finishRide(tripId);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }
}
