import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sharecars/core/utils/functions/get_userid.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';
import 'package:sharecars/features/trip_booking/data/repo/booking_rep_im.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_details/data/model/booking_model.dart';
import 'package:sharecars/features/trip_details/data/model/trip_details_mode.dart';
import 'package:sharecars/features/trip_details/data/repo/trip_details_repo.dart';
import 'package:sharecars/features/trip_me/data/repo/trip_me_repo_im.dart';

part 'tripdetails_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  final TripDetailsRepoIM tripDetailsRepoIM;

  TripDetailsCubit({required this.tripDetailsRepoIM})
      : super(TripDetailsInitial());

  booking(int seats, int tripId , String communicationNumber) async {
    emit(TripDetailsLoading());
    final response = await tripDetailsRepoIM.booking(seats, tripId ,communicationNumber);
    response.fold((error) {
      emit(TripDetailsError(message: error.message));
    }, (booking) {
      emit(TripDetailsRequestBooking(booking: booking));
    });
  }

  // cancelTripMe(int tripId) async {
  //   emit(TripInfoLoading());
  //   final response = await tripMeRepoIm.cancelTrip(tripId);
  //   response.fold((erorr) {
  //     emit(TripInfoError(message: erorr.message));
  //   }, (message) {
  //     emit(TripInfoCancel(message: message));
  //   });
  // }

  fetchTrip(int tripId) async {
    emit(TripDetailsLoading());
    final response = await tripDetailsRepoIM.featchTrip(tripId);
    response.fold((error) {
      emit(TripDetailsError(message: error.message));
    }, (trip) {
      if (trip.driver.id == myid()) {
        emit(TripDetailsLoaded(trip: trip, mode: TripDetailsMode.myView));
      } else {
        emit(TripDetailsLoaded(trip: trip, mode: TripDetailsMode.otherView));
      }
    });
  }

  fetchProfile(int userId) async {
    emit(TripDetailsGoToProfile(userId: userId));
  }

  gotoChatWithDriver(int userId) {
    emit(TripDetailsGoToChat(driverId: userId));
  }
}
