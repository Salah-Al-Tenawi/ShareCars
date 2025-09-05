import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/functions/input_valid.dart';
import 'package:sharecars/features/trip_create/data/model/trip_from.dart';

class TripAddNumberPhone extends StatefulWidget {
  const TripAddNumberPhone({super.key});

  @override
  State<TripAddNumberPhone> createState() => _TripAddNumberPhoneState();
}

class _TripAddNumberPhoneState extends State<TripAddNumberPhone> {
  final TextEditingController _phoneController = TextEditingController();
  late TripFrom tripFrom;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  @override
  void initState() {
    super.initState();
    tripFrom = Get.arguments as TripFrom;
    if (tripFrom.numberPhone != null) {
      _phoneController.text = tripFrom.numberPhone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 180.h, left: 20.w, right: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.mobileScreen,
                    size: 50,
                    color: MyColors.primary,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  const Text(
                    "رقم الهاتف للتواصل",
                    style: font18boldramdi,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "سيستخدم هذا الرقم للتواصل مع الزبائن حول تفاصيل الرحلة",
                      style: font13normaldgrey),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "أدخل رقم الهاتف",
                        suffixIcon: _isValid
                            ? const Icon(
                                Icons.check_circle,
                                color: MyColors.primaryText,
                              )
                            : const Icon(
                                Icons.check_circle,
                                color: Colors.red,
                              ),
                        prefixIcon:
                            const Icon(Icons.phone, color: MyColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "مثال: 0988626577",
                      ),
                      validator: (value) =>
                          inputvaild(value!, "nubmerphone", 10, 10)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryText,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          tripFrom.numberPhone = _phoneController.text;
                          Get.toNamed(
                            RouteName.tripDidYouBack,
                            arguments: tripFrom,
                          );
                          setState(() {
                            _isValid = true;
                          });
                        } else {
                          setState(() {
                            _isValid = false;
                          });
                        }
                      },
                      child: const Text(
                        "حفظ والمتابعة",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
