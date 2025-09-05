import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/profiles/presantaion/manger/profile_cubit.dart';

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: MyButton(
          color: MyColors.greyTextField,
          borderRadius: true,
          width: 80.w,
          onPressed: () {
            context.read<ProfileCubit>().emiteditMyProfile();
          },
          child: const Text("تعديل", style: font13Normalaccent)),
    );
  }
}
