import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_app.dart';
import 'package:sharecars/core/utils/functions/show_my_snackbar.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/auth/presentation/manger/login_cubit/login_cubit.dart';

class ColumnButtonsLogin extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;

  const ColumnButtonsLogin({
    super.key,
    required this.email,
    required this.password,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.offAllNamed(RouteName.home);
        } else if (state is LoginNavigateToSignup) {
          Get.toNamed(RouteName.singin);
        } else if (state is LoginNavigationToForgetPassword) {
          Get.toNamed(RouteName.forgetpassword);
        } else if (state is LoginError) {
          showMySnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return state is LoginLoading
            ? LottieBuilder.asset(ImagesUrl.loadinglottie)
            : Column(
                children: [
                  MyButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                              email.text.trim(),
                              password.text.trim(),
                            );
                      }
                    },
                    borderRadius: true,
                    color: MyColors.newramadi,
                    width: 140.w,
                    child: const Text(
                      "انطلق",
                      style: TextStyle(color: MyColors.greyTextField),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        onPressed: () {
                          context.read<LoginCubit>().emitgotoSingin();
                        },
                        child:
                            const Text("إنشاء حساب", style: font14normalblue),
                      ),
                      const Text("ليس لديك حساب بالفعل ؟"),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(".  .  .  .  .  .        ",
                          style: TextStyle(color: MyColors.blueColor)),
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          child:
                              Image(image: AssetImage(ImagesUrl.imagegoogle)),
                        ),
                      ),
                      const Text("       .  .  .  .  .  .  .",
                          style: TextStyle(color: MyColors.blueColor)),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
