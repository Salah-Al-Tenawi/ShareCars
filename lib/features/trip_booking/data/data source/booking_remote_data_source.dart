import 'package:sharecars/core/api/api_consumer.dart';
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/features/trip_booking/data/model/booking_me_model.dart';

class BookingRemoteDataSource {
  final ApiConSumer _api;

  BookingRemoteDataSource({required ApiConSumer api}) : _api = api;

  Future<BookingMeModel> getmeBooking() async {
    final response = await _api.get(ApiEndPoint.baserUrl,
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});
    return BookingMeModel.fromJson(response);
  }

// todo Modleing
  Future<dynamic> cancelBooking(int bookingId, int seats) async {
    final url = "${ApiEndPoint.baserUrl}/bookings/$bookingId/cancel-seats";

    final response = await _api.post(
      url,
      header: {
        ApiKey.authorization: "Bearer ${mytoken()}",
      },
      data: {
        "seats_to_cancel": seats,
      },
    );

    return response;
  }
}
