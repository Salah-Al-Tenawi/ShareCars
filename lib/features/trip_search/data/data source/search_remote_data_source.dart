import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

class SearchRemoteDataSource {
  final DioConSumer api;

  SearchRemoteDataSource({required this.api});

  Future<List<TripModel>> search(
    String sourcelat,
    String sourcelng,
    String destlat,
    String destlng,
    String departureDate,
    int seatsRequired,
  ) async {
    final response = await api.post(
      ApiEndPoint.search,
      header: {ApiKey.authorization: "Bearer ${mytoken()}"},
      data: {
        ApiKey.sourcelat: sourcelat,
        ApiKey.sourcelng: sourcelng,
        ApiKey.destlat: destlat,
        ApiKey.destlng: destlng,
        ApiKey.departureDate: departureDate,
        ApiKey.seatsRequired: seatsRequired,
      },
    );

    // استخدام fromJson لتحويل response إلى قائمة TripModel
    final trips = TripModel.fromJson(response);

    return trips;
  }

  Future<TripModel> showOneTrip(int tripId) async {
    final response = await api.get("${ApiEndPoint.rides}/$tripId",
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});

    return TripModel.fromMap(response);
  }

  // Future<RequestBookingModel> booking(int seats, int tripId) async {
  //   final response = await api
  //       .post("${ApiEndPoint.rides}/$tripId/book", data: {ApiKey.seats: seats});
  //   return response;
  // }
}
