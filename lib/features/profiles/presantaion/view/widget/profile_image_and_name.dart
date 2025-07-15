import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/features/profiles/data/model/enum/image_mode.dart';
import 'package:sharecars/features/profiles/data/model/enum/profile_mode.dart';
import 'package:sharecars/core/utils/functions/show_image.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/profiles/domain/entity/profile_entity.dart';
import 'package:sharecars/features/profiles/presantaion/manger/profile_cubit.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/get_profile_image.dart';
import 'package:sharecars/features/profiles/presantaion/view/widget/profile_verification_icon.dart';

class ProfileImageAndName extends StatelessWidget {
  final ProfileEntity? profileEntitYEdit;
  final String? imageurl;
  final String name;
  final String verification;

  const ProfileImageAndName({
    super.key,
    required this.imageurl,
    required this.name,
    required this.verification,
    this.profileEntitYEdit,
  });

  void _onPickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (pickedFile != null) {
      context.read<ProfileCubit>().pickImage(
            pickedFile,
            ProfileImagePicMode.user,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                final mode = state.mode;

                if (mode == ProfileMode.myEdit) {
                  return MyButton(
                    splashcolor: Colors.white,
                    onPressed: () => _onPickImage(context),
                    child: CircleAvatar(
                      backgroundColor: MyColors.primary,
                      maxRadius: 45,
                      backgroundImage: getProfileImage(
                          context, profileEntitYEdit?.profilePhoto),
                    ),
                  );
                }

                return MyButton(
                  splashcolor: Colors.white,
                  onPressed: () {
                    openImage(imageurl ?? ImagesUrl.profileImage);
                  },
                  child: CircleAvatar(
                    backgroundColor: MyColors.primary,
                    maxRadius: 45,
                    backgroundImage: imageurl == null
                        ? const AssetImage(ImagesUrl.profileImage)
                        : NetworkImage(imageurl!) as ImageProvider,
                  ),
                );
              }

              return CircleAvatar(
                backgroundColor: MyColors.primary,
                maxRadius: 45,
                backgroundImage: imageurl == null
                    ? const AssetImage(ImagesUrl.profileImage)
                    : NetworkImage(imageurl!) as ImageProvider,
              );
            },
          ),
        ),
        const ProfileVerificationIcon(),
        SizedBox(width: 15.w),
        Expanded(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                return Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryText,
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
