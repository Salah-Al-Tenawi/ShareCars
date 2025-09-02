part of 'booking_me_cubit.dart';

sealed class BookingMeState extends Equatable {
  const BookingMeState();

  @override
  List<Object> get props => [];
}

final class BookingMeInitial extends BookingMeState {} 
final class BookingMeloading extends BookingMeState {} 


final class BookingMeErorr extends BookingMeState {
  final String message;

  const BookingMeErorr({required this.message});
}

final class BookingMeListLoaded extends BookingMeState {
  final List<BookingMe> bookings;
  const BookingMeListLoaded({required this.bookings});
}

final class BookingMeCanceled extends BookingMeState {
  final String message;

  const BookingMeCanceled({required this.message});
}
final class BookingMeFinish extends BookingMeState {
  final String message;

  const BookingMeFinish({required this.message});
}
