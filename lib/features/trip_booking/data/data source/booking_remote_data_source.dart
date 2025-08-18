// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sharecars/core/api/api_consumer.dart';
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/features/trip_booking/data/model/request_booking_model.dart';

class BookingRemoteDataSource {
  final ApiConSumer api;
  const BookingRemoteDataSource({
    required this.api,
  });
  Future<RequestBookingModel> booking(int seats, int tripId) async {
    final response = await api.post("${ApiEndPoint.rides}/$tripId/book",  
    data: {ApiKey.seats: seats});
    return response;
  }
}
