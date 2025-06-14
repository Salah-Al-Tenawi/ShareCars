// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/them/text_app.dart';

class TripDateShow extends StatelessWidget {
  final String day;
  final String hour;
  const TripDateShow({
    super.key,
    required this.day,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 40.h),
      decoration: BoxDecoration(
          color: MyColors.newgrey,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.newramadi, width: 0.2),
          boxShadow: const [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(7, 7),
                color: MyColors.newramadi)
          ]),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(day, style: font14boldblueblack),
              SizedBox(
                width: 37.w,
              ),
              const FaIcon(FontAwesomeIcons.calendarDay,
                  size: 14, color: MyColors.newrskey),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(hour, style: font14boldblueblack),
              SizedBox(
                width: 50.w,
              ),
              const FaIcon(FontAwesomeIcons.clock,
                  size: 15, color: MyColors.newrskey),
            ],
          ),
        ],
      ),
    );
  }
}
