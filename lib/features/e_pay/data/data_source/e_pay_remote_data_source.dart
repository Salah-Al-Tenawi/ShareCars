import 'package:flutter/material.dart';
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/features/e_pay/data/model/balance_model.dart';

class EPayRemoteDataSource {
  final DioConSumer api;

  EPayRemoteDataSource({required this.api});

  Future<dynamic> initWallet(String numberPhone, String password) async {
    final response = await api.post(ApiEndPoint.baserUrl, header: {
      ApiKey.authorization: "Bearer ${mytoken()}"
    }, data: {
      ApiKey.phoneNumber: numberPhone,
      ApiKey.password: password,
    });
    return response;
  }

//todo model
  Future<dynamic> createWallet(String numberPhone, String otpCode) async {
    final response = await api.post(
      ApiEndPoint.baserUrl,
      header: {ApiKey.authorization: "Bearer ${mytoken()}"},
      data: {
        ApiKey.phoneNumber: numberPhone,
        ApiKey.otpCode: Orientation.portrait
      },
    );
    return response;
  }

  Future<BalanceModel> getBalance() async {
    final response = await api.get(
      ApiEndPoint.getbalance,
      header: {ApiKey.authorization: "Bearer ${mytoken()}"},
    );
    return BalanceModel.fromJson(response);
  }
}
