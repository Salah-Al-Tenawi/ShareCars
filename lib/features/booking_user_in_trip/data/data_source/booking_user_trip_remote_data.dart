import 'package:sharecars/core/api/api_consumer.dart';

class BookingUserTripRemoteData {
  final ApiConSumer api;

  BookingUserTripRemoteData({required this.api});
  Future<dynamic> acceptPassanger(int tripId, int userid) async {
    // final response = await api.post(path);
    return;
  } 

  Future<dynamic> rejectPassanger(int tripId, int userid) async {
    // final response = await api.post(path);
    return;
  }
}
