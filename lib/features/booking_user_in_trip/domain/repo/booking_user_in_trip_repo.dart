import 'package:dartz/dartz.dart';
import 'package:sharecars/core/errors/filuar.dart';

abstract class BookingUserInTripRepo {
  Future<Either<Filuar, dynamic>> acceptPassanger(int tipId, int userid);
  Future<Either<Filuar, dynamic>> rejectPassanger(int tipId, int userid);
  
}
