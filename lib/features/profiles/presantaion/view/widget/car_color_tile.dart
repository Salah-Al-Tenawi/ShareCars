import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/widgets/cutom_list_tile.dart';

class CarColorTile extends StatelessWidget {
  final String ?color;

  const CarColorTile({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: "لون",
      titleTextStyle: font15BoldRamadi,
      iconleading: const Icon(Icons.color_lens, size: 20, color: MyColors.primary),
      subtitle: Text(
        color??"",
        style: const TextStyle(color: MyColors.greyTextColor),
      ),
    );
  }
}
