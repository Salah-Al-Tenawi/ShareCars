import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sharecars/features/booking_user_in_trip/data/repo/booking_users_in_trip_repo_imp.dart';

part 'booking_user_in_trip_state.dart';

class BookingUserInTripCubit extends Cubit<BookingUserInTripState> {
  final BookingUsersInTripRepoImp repo;
  BookingUserInTripCubit(this.repo) : super(BookingUserInTripInitial());

  
  acceptPassanger(int tripId, int userId) async {
    emit(BookingUserInTripLoading());
    await Future.delayed(const Duration(seconds: 2));
    final response = await repo.acceptPassanger(tripId, userId);
    response.fold(
      (error) => emit(BookingUserInTripErorr(message: error.message)),
      (succ) => emit(BookingUserInTripUpdated(
        userId: userId,
        newStatus: "completed",
      )),
    );
  }

  rejectPassanger(int tripId, int userId) async {
    emit(BookingUserInTripLoading());
    await Future.delayed(const Duration(seconds: 2));
    final response = await repo.rejectPassanger(tripId, userId);
    response.fold(
      (error) => emit(BookingUserInTripErorr(message: error.message)),
      (succ) => emit(BookingUserInTripUpdated(
        userId: userId,
        newStatus: "rejected",
      )),
    );
  }
}
