// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/service/hive_services.dart';
import 'package:sharecars/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  final DioConSumer api;
  const AuthRemoteDataSource({
    required this.api,
  });

  Future<UserModel> login(String email, String password);
  Future<UserModel> singin(String firstName, String lastName, String gender,
      String email, String address, String password, String verfiyPassword);
  Future forgetPassword(String email);
  Future logout();
}

class AuthRemoteDataSourceIM extends AuthRemoteDataSource {
  AuthRemoteDataSourceIM({required super.api});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await api.post(ApiEndPoint.login,
        data: {ApiKey.email: email, ApiKey.password: password});
    HiveBoxes.authBox.put(HiveKeys.user, response);
    return UserModel.fromjson(response);
  }

  @override
  Future<UserModel> singin(
      String firstName,
      String lastName,
      String gender,
      String email,
      String address,
      String password,
      String verfiyPassword) async {
    final response = await api.post(ApiEndPoint.singin, data: {
      ApiKey.firstName: firstName,
      ApiKey.lastName: lastName,
      ApiKey.email: email,
      ApiKey.password: password,
      ApiKey.passwordConfirm: verfiyPassword,
      ApiKey.gender: gender,
      ApiKey.address: address,
    });
    HiveBoxes.authBox.put(HiveKeys.user, response);
    return UserModel.fromjson(response);
  }

// to do
  @override
  Future<String> logout() async {
    final response = await api.post(ApiEndPoint.logout, header: {
      // "Authorization":
      //     "Bearer ${token from cach}"
    });
    return response;
  }

  @override
  Future forgetPassword(String email) async {
    final response =
        await api.post(ApiEndPoint.forgetPassword, data: {ApiKey.email: email});
    return response;
  }
}
