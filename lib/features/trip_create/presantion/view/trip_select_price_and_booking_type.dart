import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_style_app.dart';
import 'package:sharecars/core/utils/widgets/my_button.dart';
import 'package:sharecars/features/trip_create/data/model/trip_from.dart';
import 'package:sharecars/features/trip_create/presantion/view/widget/trip_select_booking_type.dart';
import 'package:sharecars/features/trip_create/presantion/view/widget/trip_select_price.dart';
import 'package:sharecars/features/trip_create/presantion/view/widget/trip_text_note.dart';

class TripSelectPriceAndBookingType extends StatefulWidget {
  const TripSelectPriceAndBookingType({super.key});

  @override
  State<TripSelectPriceAndBookingType> createState() =>
      _TripSelectPriceAndBookingTypeState();
}

class _TripSelectPriceAndBookingTypeState
    extends State<TripSelectPriceAndBookingType> {
  late TripFrom tripFrom;
  late String recomandedprice;

  @override
  void initState() {
    super.initState();
    tripFrom = Get.arguments as TripFrom;
    recomandedprice = "السعر المناسب ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 80.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                " السعر للراكب الواحد بالليرة السورية",
                style: font15BoldRamadi,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(recomandedprice, style: font25boldgreen),
              TripSelectPrice(tripFrom: tripFrom),
              const Divider(
                color: MyColors.primaryText,
                endIndent: 100,
                indent: 100,
                thickness: 0.3,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                "اختر نوع الحجز ",
                style: font15BoldRamadi,
              ),
              TripSelectBookingType(tripFrom: tripFrom),
              const TripTextNote(),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 160.w),
                child: MyButton(
                  onPressed: () {
                    Get.toNamed(RouteName.tripAddNumberPhone,
                        arguments: tripFrom);
                  },
                  color: MyColors.primaryText,
                  width: 130.w,
                  height: 50.h,
                  borderRadius: true,
                  splashcolor: MyColors.primary,
                  child: const Text(
                    "التالي",
                    style: font13boldwhite,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
