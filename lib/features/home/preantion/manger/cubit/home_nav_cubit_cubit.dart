import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/features/auth/data/repo/auth_repo_im.dart';

class HomeNavCubit extends Cubit<int> {
  final AuthRepoIm _authRepoIm;
  HomeNavCubit(this._authRepoIm) : super(1);

  void changePage(int index) => emit(index);

  Future<void> logout(BuildContext context) async {
    final response = await _authRepoIm.logout();

    response.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red,
          ),
        );
      },
      (success) {
        Get.offAllNamed(RouteName.login); 
      },
    );
  }
}
