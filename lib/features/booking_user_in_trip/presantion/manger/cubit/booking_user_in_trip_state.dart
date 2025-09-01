part of 'booking_user_in_trip_cubit.dart';

sealed class BookingUserInTripState extends Equatable {
  const BookingUserInTripState();

  @override
  List<Object> get props => [];
}

final class BookingUserInTripInitial extends BookingUserInTripState {}

final class BookingUserInTripLoading extends BookingUserInTripState {}

final class BookingUserInTripErorr extends BookingUserInTripState {
  final String message;

  const BookingUserInTripErorr({required this.message});
}
final class BookingUserInTripUpdated extends BookingUserInTripState {
  // final int userId;
  final String newStatus; // مثلا "accepted" أو "rejected"

  const BookingUserInTripUpdated({
    // required this.userId,
    required this.newStatus,
  });

  @override
  List<Object> get props => [newStatus];
}
  

final class BookingUserInTripSucc extends BookingUserInTripState{}
// final class BookingUserInTripAccep
