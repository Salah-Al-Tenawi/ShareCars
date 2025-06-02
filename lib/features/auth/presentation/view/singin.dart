import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/widgets/cricular_decoration.dart';
import 'package:sharecars/features/auth/presentation/view/widget/button_singin.dart';
import 'package:sharecars/features/auth/presentation/view/widget/drop_down_and_gender_sing.dart';
import 'package:sharecars/features/auth/presentation/view/widget/text_fileds_singin.dart';

class Singin extends StatefulWidget {
  const Singin({super.key});

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CricularDecoration(
                heghit: 100,
                width: 120,
                color: MyColors.newrskey,
              ),
              TextFieldsSingin(
                firstname: firstname,
                lastname: lastname,
                email: email,
                password: password,
                passwordConfirm: passwordConfirm,
              ),
              const DropDownAndGenderSing(),
              SizedBox(
                height: 50.h,
              ),
              ButtonSingin(
                firstname: firstname,
                lastname: lastname,
                email: email,
                formKey: formKey,
                password: password,
                passwordConfirm: passwordConfirm,
              )
            ],
          ),
        ),
      ),
    );
  }
}
