import 'package:flutter/material.dart';
import 'package:sharecars/core/them/my_colors.dart';

class ProfileContactMe extends StatelessWidget {
  const ProfileContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        // Get.toNamed("dsf");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: MyColors.newrskey,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chat_sharp,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
