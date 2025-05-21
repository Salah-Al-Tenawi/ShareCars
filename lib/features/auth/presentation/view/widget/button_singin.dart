
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/functions/show_my_snackbar.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/auth/presentation/manger/singin_cubit/singin_cubit.dart';
import 'package:lottie/lottie.dart';


class ButtonSingin extends StatelessWidget {
  const ButtonSingin({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.formKey,
  });

  final TextEditingController firstname;
  final TextEditingController lastname;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirm;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SinginCubit>(); // 👈 يراقب التغييرات تلقائيًا

    return BlocConsumer<SinginCubit, SinginState>(
      listener: (context, state) {
        if (state is SinginSuccess) {
          Get.offAllNamed(RouteName.home);
        } else if (state is SinginErorre) {
          showMySnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return state is SinginLoading
            ?  LottieBuilder.asset(
                      ImagesUrl.loadinglottie,
                      height: 80,
                    )
            : MyButton(
                onPressed: () {
                  final fname = firstname.text.trim();
                  final lname = lastname.text.trim();
                  final mail = email.text.trim();
                  final pass = password.text.trim();
                  final confirm = passwordConfirm.text.trim();
                  final gender = cubit.gender;
                  final address = cubit.address;
                  if (formKey.currentState!.validate()) {
                    context.read<SinginCubit>().singin(
                          fname,
                          lname,
                          gender,
                          mail,
                          address ?? "دمشق",
                          pass,
                          confirm,
                        );
                  }
                },
                borderRadius: true,
                color: MyColors.newramadi,
                height: 50.h,
                width: 170.w,
                child: const Text(
                  "إنشاء حساب",
                  style: TextStyle(color: MyColors.greyTextField),
                ),
              );
      },
    );
  }
}
