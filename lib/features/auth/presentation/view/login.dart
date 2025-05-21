import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/widgets/cricular_decoration.dart';
import 'package:sharecars/features/auth/presentation/view/widget/buttons_login.dart';
import 'package:sharecars/features/auth/presentation/view/widget/text_fileds_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

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
              SizedBox(
                height: 80.h,
              ),
              TextFiledsLogin(
                email: email,
                password: password,
              ),
              ColumnButtonsLogin(
                email: email,
                password: password,
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
