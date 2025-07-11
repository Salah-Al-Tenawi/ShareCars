import 'package:flutter/material.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/functions/show_image.dart';
import 'package:sharecars/core/utils/widgets/cutom_list_tile.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/profiles/domain/entity/car_entity.dart';

class ProfileCarInfoView extends StatelessWidget {
  final CarEntity car;
  const ProfileCarInfoView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          endIndent: 100,
          indent: 100,
        ),
        Row(
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
            Text(
              car.type,
              style: font12boldRamadi,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomListTile(
                title: "لون",
                titleTextStyle: font15BoldRamadi,
                iconleading: const Icon(
                  Icons.color_lens,
                  size: 20,
                  color: MyColors.primary,
                ),
                subtitle: Text(
                  car.color,
                  style: const TextStyle(color: MyColors.greyTextColor),
                ),
              ),
            ),
            Expanded(
              child: CustomListTile(
                title: "عدد الكراسي",
                titleTextStyle: font15BoldRamadi,
                iconleading: const Icon(
                  Icons.chair,
                  size: 20,
                  color: MyColors.primary,
                ),
                subtitle: Text(
                  "${car.seats}",
                  style: fontdefualtGreyText,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomListTile(
                title: "الراديو",
                titleTextStyle: font15BoldRamadi,
                iconleading:
                    const Icon(Icons.radio, size: 20, color: MyColors.primary),
                subtitle: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: car.hasRadio
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        car.hasRadio ? Icons.check : Icons.close,
                        size: 16,
                        color: car.hasRadio ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        car.hasRadio ? "متاح" : "غير متاح",
                        style: TextStyle(
                          color: car.hasRadio ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomListTile(
                title: "التدخين",
                titleTextStyle: font15BoldRamadi,
                iconleading: const Icon(Icons.smoking_rooms,
                    size: 20, color: MyColors.primary),
                subtitle: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: car.allowsSmoking == true
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        car.allowsSmoking ? Icons.check : Icons.close,
                        size: 16,
                        color: car.allowsSmoking == true
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        car.allowsSmoking ? "مسموح" : "ممنوع",
                        style: TextStyle(
                          color: car.allowsSmoking ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
