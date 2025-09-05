import 'package:flutter/material.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/functions/show_image.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/profiles/domain/entity/car_entity.dart';

class CarImageViewerTile extends StatelessWidget {
  final CarEntity car;

  const CarImageViewerTile({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: MyButton(
            onPressed: () {
              car.image != null
                  ? openImage(car.image!)
                  : openImage(ImagesUrl.defualtCar);
            },
            child: CircleAvatar(
              backgroundColor: MyColors.primary,
              maxRadius: 30,
              backgroundImage: car.image == null
                  ? const AssetImage(ImagesUrl.defualtCar)
                  : NetworkImage(car.image!) as ImageProvider,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          car.type!,
          style: font12boldRamadi,
        ),
      ],
    );
  }
}
