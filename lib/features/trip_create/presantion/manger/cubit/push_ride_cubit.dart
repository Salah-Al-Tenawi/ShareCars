import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sharecars/core/utils/functions/input_valid.dart';
import 'package:sharecars/features/trip_create/data/model/trip_from.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_create/data/repo/trip_create_repo_im.dart';

part 'push_ride_state.dart';

class PushRideCubit extends Cubit<PushRideState> {
  PushRideCubit(this.tripCreateRepoIm) : super(PushRideInitial());
  final TripCreateRepoIm tripCreateRepoIm;

  pushRide(TripFrom trip) async {
    String? startLat = trip.startLat;
    String? startLng = trip.startLng;
    String? endLat = trip.endLat;
    String? endLng = trip.endLng;
    String? date = trip.date;
    int seats = trip.numberSeats;
    int price = trip.price;
    String notes = trip.notes;
    int routeIndex = trip.path;
    String paymentMethod = trip.cashType;
    String bookingType = trip.bookingType;

    emit(PushRideLoading());

    final response = await tripCreateRepoIm.createTrip(
        startLat!,
        startLng!,
        endLat!,
        endLng!,
        date!,
        seats,
        price,
        notes,
        routeIndex,
        paymentMethod,
        bookingType);

    response.fold((error) {
      emit(PushRideErorr());
    }, (tripModle) {
      emit(PushRideSuccsess(tripModel: tripModle));
    });
  } 
  void validatePhone(String value) {
  final isValid = inputvaild(value, "nubmerphone", 10, 10) == null;
  emit(PushRideValidatePhoneState(isValid));
}
}
