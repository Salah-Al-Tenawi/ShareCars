import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharecars/features/profiles/data/model/enum/profile_mode.dart';
import 'package:sharecars/features/profiles/domain/entity/car_entity.dart';
import 'package:sharecars/features/profiles/presantaion/manger/profile_cubit.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/Profile_car_info_edit.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/profile_car_info_view.dart';

class ProfileCar extends StatelessWidget {
  final CarEntity? car;
  final CarEntity? carWitheidt;
  final ProfileMode mode;

  const ProfileCar({
    super.key,
    required this.car,
    required this.carWitheidt,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    // if (car == null && mode != ProfileMode.myEdit) {
    //   return const SizedBox();
    // }

    switch (mode) {
      case ProfileMode.otherView:
      case ProfileMode.myView:
        return ProfileCarInfoView(car: car);
      case ProfileMode.myEdit:
        return ProfileCarInfoEdit(carWithEdit: carWitheidt);
    }
  }
}
