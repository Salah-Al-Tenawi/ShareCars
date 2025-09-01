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
  const HomeDrawer({super.key, required this.scaffoldContext});

  get font15ggreyw600 => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.primaryBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileTile(),
          _buildDivider(),
          _buildVerificationTile(),
          _buildDivider(),
          _buildLogoutTile(),
        ],
      ),
    );
  }

  /// 🔹 بروفايلي
  Widget _buildProfileTile() {
    return CustomListTile(
      title: "بروفايلي",
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      titleTextStyle: font15ggreyw600,
      onTap: () => Get.toNamed(RouteName.profile, arguments: myid()),
      trailing: const Icon(
        Icons.person_pin_sharp,
        color: MyColors.accent,
        size: 30,
      ),
    );
  }

  /// 🔹 توثيق الهوية
  Widget _buildVerificationTile() {
    return CustomListTile(
      title: "توثيق الهوية",
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      titleTextStyle: font15ggreyw600,
      onTap: () {
        showDialog(
          context: scaffoldContext,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Row(
                children: [
                  Icon(Icons.verified_user, color: MyColors.primary, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "توثيق الهوية",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: const Text(
                "حرصًا على أمانك وأمان جميع مستخدمي التطبيق، "
                "ولمنع الحسابات الوهمية والأشخاص غير الموثوقين، "
                "نطلب منك إتمام عملية توثيق الهوية.\n\n"
                "لن تتمكن من حجز الرحلات أو إنشاء رحلات جديدة "
                "إلا بعد إتمام التوثيق بنجاح.",
                style:
                    TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(RouteName.verfiyUser,
                                arguments: "driver");
                          },
                          icon: const Icon(Icons.directions_car,
                              color: Colors.white),
                          label: const Text(
                            "توثيق كسائق",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(RouteName.verfiyUser,
                                arguments: "passanger");
                          },
                          icon: const Icon(Icons.person, color: Colors.white),
                          label: const Text(
                            "توثيق كمسافر",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      trailing: const Icon(
        Icons.verified_user,
        color: MyColors.accent,
        size: 28,
      ),
    );
  }

  /// 🔹 تسجيل الخروج
  Widget _buildLogoutTile() {
    return CustomListTile(
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
                  color: MyColors.accent,
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
                  child: const Text("نعم", style: font13NormalGrayText),
                ),
              ],
            );
          },
        );
      },
      trailing: const Icon(
        Icons.login_outlined,
        color: MyColors.accent,
        size: 30,
      ),
    );
  }

  /// 🔹 Divider مشترك
  Widget _buildDivider() {
    return Divider(
      color: MyColors.greyTextfildColor,
      endIndent: 70,
      indent: 70,
    );
  }
}
