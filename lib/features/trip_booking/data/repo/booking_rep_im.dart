// import 'package:dartz/dartz.dart';
// import 'package:sharecars/core/errors/excptions.dart';
// import 'package:sharecars/core/errors/filuar.dart';
// import 'package:sharecars/features/trip_booking/data/data%20source/booking_remote_data_source.dart';
// import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';
// import 'package:sharecars/features/trip_booking/domain/repo/booking_repo.dart';
// import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

// class BookingRepIm extends BookingRepo {
//   final BookingRemoteDataSource bookingRemoteDataSource;

//   BookingRepIm({required this.bookingRemoteDataSource});
//   @override
//   Future<Either<Filuar, TripModel>> booking(int seats, int tripId) async {
//     try {
//       final response = await bookingRemoteDataSource.booking(seats, tripId);
//       return right(response);
//     } on ServerExpcptions catch (e) {
//       return left(e.error);
//     }
//   }
// }
