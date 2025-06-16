import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/profiles/domain/entity/comment_entity.dart';

class ProfileComments extends StatelessWidget {
  final List<CommentEntity>? feadBack;
  const ProfileComments({super.key, required this.feadBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          border: Border.all(width: 0.3, color: MyColors.primaryBackground),
          borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feadBack?.length,
          itemBuilder: (context, counter) {
            return const Comment();
          }),
    );
  }
}

class Comment extends StatelessWidget {
  final CommentEntity? commentEntity;
  const Comment({super.key, this.commentEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3, color: MyColors.primaryBackground),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  commentEntity!.authorName,
                  style: font12boldRamadi,
                ),
                const SizedBox(height: 5),
                Text(
                  commentEntity!.text,
                  style: font10boldRamadi,
                  textDirection: TextDirection.rtl,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    commentEntity!.createdAt,
                    style: const TextStyle(
                        fontSize: 6.2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.greyTextColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.w),
          MyButton(
            onPressed: () {
              Get.toNamed(RouteName.profile, arguments: commentEntity!.iduser);
            },
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: MyColors.primary,
              backgroundImage: commentEntity?.authorPhoto != null
                  ? NetworkImage(commentEntity!.authorPhoto!)
                  : const AssetImage(ImagesUrl.profileImage) as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }
}
