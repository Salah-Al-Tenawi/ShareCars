import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/functions/get_userid.dart';
import 'package:sharecars/core/utils/widgets/cutom_list_tile.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/home/preantion/manger/cubit/home_nav_cubit_cubit.dart';

class HomeDrawer extends StatelessWidget {
  final BuildContext scaffoldContext;
  const HomeDrawer({
    super.key,
    required this.scaffoldContext,
  });

  get font15ggreyw600 => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomListTile(
            title: "بروفايلي",
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            titleTextStyle: font15ggreyw600,
            onTap: () {
              Get.toNamed(RouteName.profile, arguments: myid());
            },
            trailing: const Icon(
              Icons.person_pin_sharp,
              color: MyColors.primaryText,
              size: 30,
            ),
          ),
          Divider(
            color: MyColors.greyTextfildColor,
            endIndent: 70,
            indent: 70,
          ),
          CustomListTile(
            title: "تسجيل الخروج",
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            titleTextStyle: font15ggreyw600,
            onTap: () {
              showDialog(
                context: scaffoldContext,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text("تأكيد"),
                    content: const Text("هل أنت متأكد من تسجيل الخروج؟"),
                    actions: [
                      MyButton(
                        color: MyColors.greyTextColor,
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text("لا", style: font13NormalGrayText),
                      ),
                      MyButton(
                        color: MyColors.primary,
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          scaffoldContext
                              .read<HomeNavCubit>()
                              .logout(scaffoldContext);
                        },
                        child: const Text(
                          "نعم",
                          style: font13NormalGrayText,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            trailing: const Icon(
              Icons.login_outlined,
              color: MyColors.primaryText,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
