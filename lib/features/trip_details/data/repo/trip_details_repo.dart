import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/excptions.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_details/data/data_source/trip_details_remote_data_source.dart';
import 'package:sharecars/features/trip_details/domain/repo/trip_details_repo.dart';

class TripDetailsRepoIM extends TripDetailsRepo {
  final TripDetailsRemoteDataSource remoteDataSource;

  TripDetailsRepoIM({required this.remoteDataSource});

  @override
  Future<Either<Filuar, TripModel>> featchTrip(int tripId) async {
    try {
      final response = await remoteDataSource.featchTrip(tripId);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }

  Future<Either<Filuar, RequestBookingModel>> booking(
      int seats, int tripId) async {
    try {
      final response = await remoteDataSource.booking(seats, tripId);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }
}
