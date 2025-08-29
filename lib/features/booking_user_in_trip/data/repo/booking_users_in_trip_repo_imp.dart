import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/excptions.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/booking_user_in_trip/data/data_source/booking_user_trip_remote_data.dart';
import 'package:sharecars/features/booking_user_in_trip/domain/repo/booking_user_in_trip_repo.dart';

class BookingUsersInTripRepoImp extends BookingUserInTripRepo {
  final BookingUserTripRemoteData remoteData;

  BookingUsersInTripRepoImp({required this.remoteData});

  @override
  Future<Either<Filuar, dynamic>> acceptPassanger(int tirpId, int userid) async {
    try {
      final response = await remoteData.acceptPassanger(tirpId, userid);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }

  @override
  Future<Either<Filuar, dynamic>> rejectPassanger(int tipId, int userid) async{
    try {
      final response = await remoteData.rejectPassanger(tipId, userid);
      return right(response);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    }
  }
}
