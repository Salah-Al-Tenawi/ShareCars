  import 'package:bloc/bloc.dart';
  import 'package:equatable/equatable.dart';
  import 'package:sharecars/features/trip_booking/data/model/booking_me_model.dart';
  import 'package:sharecars/features/trip_booking/data/model/cancel_booking_model.dart';
  import 'package:sharecars/features/trip_booking/data/repo/booking_me_repo.dart';

  part 'booking_me_state.dart';

  class BookingMeCubit extends Cubit<BookingMeState> {
    final BookingMeRepo _repo;

    BookingMeCubit(this._repo) : super(BookingMeInitial());

    Future getMyBooking() async {
      emit(BookingMeListloading());

      final response = await _repo.getMeBooking();

      response.fold(
        (error) => emit(BookingMeErorr(message: error.message)),
        (listBooking) => emit(BookingMeListLoaded(bookings: listBooking)),
      );
    }

    cancelBooking(int bookingId, int seats) async {
      emit(BookingMeloading());
      final response = await _repo.cancelBooking(bookingId, seats);
      response.fold((erorr) {
        emit(BookingMeErorr(message: erorr.message));
      }, (cancel) {
        emit(BookingMeCanceled(cancelModel: cancel));
      });
    }

    finishTrip(int bookingId) async {
      emit(BookingMeloading());
      final response = await _repo.finshTrip(bookingId);
      response.fold((erorr) {
        emit(BookingMeErorr(message: erorr.message));
      }, (sucess) {
        emit(const BookingMeFinish(message: "تم التأكيد"));
      });
    }

    reateUser(double rating, int userId) async {
      emit(BookingMeloading());
      final response = await _repo.rateUser(rating, userId);

      response.fold((erorr) {
        emit(const BookingMeErorr(message: "فشل التقيم"));
      }, (rate) {
        emit(BookingMeRated(rate: rate.averageRating));
      });
    }

    addComment(String comment, int userid) async {
      final response = await _repo.addcommit(comment, userid);
      response.fold((erorr) {
        emit(const BookingMeErorr(message: "فشل في اضافة تعليق"));
      }, (succ) {
        emit(BookingMeCommented());
      });
    }
  }
