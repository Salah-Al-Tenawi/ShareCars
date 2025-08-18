import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

class SearchRemoteDataSource {
  final DioConSumer api;

  SearchRemoteDataSource({required this.api});

  Future<List<TripModel>> search(
      String sourceAddress,
      String destinationAddress,
      String departureDate,
      int seatsRequired) async {
    final response = await api.post(ApiEndPoint.search, header: {
      ApiKey.authorization: "Bearer ${mytoken()}"
    }, data: {
      ApiKey.sourceAddress: sourceAddress,
      ApiKey.destinationAddress: destinationAddress,
      ApiKey.departureDate: departureDate,
      ApiKey.seatsRequired: seatsRequired
    });
     final trips = response
      .map((e) => TripModel.fromJson(e))
      .toList();

  return trips;
  }
}
