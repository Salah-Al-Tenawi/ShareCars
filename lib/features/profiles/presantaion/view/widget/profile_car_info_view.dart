import 'package:flutter/material.dart';
import 'package:sharecars/features/profiles/domain/entity/car_entity.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/car_color_tile.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/car_image_view_tile.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/car_radio_info_tile.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/car_seats_tile.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/car_smoking_info_tile.dart';

class ProfileCarInfoView extends StatelessWidget {
  final CarEntity ?car;

  const ProfileCarInfoView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return 
    
    car !=null?
     Column(
      children: [
        const Divider(endIndent: 100, indent: 100),
        CarImageViewerTile(car: car!),
        Row(
          children: [
            Expanded(child: CarColorTile(color: car!.color)),
            Expanded(child: CarSeatsTile(seats: car!.seats)),
          ],
        ),
        Row(
          children: [
            Expanded(child: CarRadioInfoTile(hasRadio: car!.hasRadio)),
            Expanded(child: CarSmokingInfoTile(allowsSmoking: car!.allowsSmoking)),
          ],
        ),
      ],
    ) :const Text("");
  }
}
