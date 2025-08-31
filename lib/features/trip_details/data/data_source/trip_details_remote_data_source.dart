import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_details/data/model/booking_model.dart';

class TripDetailsRemoteDataSource {
  final DioConSumer api;

  TripDetailsRemoteDataSource({required this.api});

  Future<TripModel> featchTrip(int tripId) async {
    final response = await api.get("${ApiEndPoint.rides}/$tripId",
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});

    return TripModel.fromMap(response);
  }

  Future<BookingResponse> booking(
      int seats, int tripId, String communicationNumber) async {
    final response = await api.post("${ApiEndPoint.rides}/$tripId/book",
        header: {
          ApiKey.authorization: "Bearer ${mytoken()}"
        },
        data: {
          ApiKey.seats: seats,
          ApiKey.communicationNumber: communicationNumber
        });
    return BookingResponse.fromJson(response);
  }
}
