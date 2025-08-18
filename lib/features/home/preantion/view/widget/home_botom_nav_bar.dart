import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/constant/const_text.dart';
import 'package:sharecars/core/utils/functions/get_userid.dart';
import 'package:sharecars/features/home/preantion/manger/cubit/home_nav_cubit_cubit.dart';

class BottomNavBarWidget extends StatelessWidget {
  final PageController pageController;
  const BottomNavBarWidget({super.key, required this.pageController});
  final List<IconData> _navIcons = const [
    Icons.directions_car,
    Icons.search_rounded,
    Icons.list_alt_rounded,
  ];

  final List<Color> _activeColors = const [
    MyColors.primary,
    MyColors.accent,
    MyColors.primaryBackground,
    MyColors.primaryBackground,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, int>(
      builder: (context, currentIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.primaryBackground, width: 0.2),
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 16.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Container(
                height: 77.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(158, 158, 158, 0.1),
                    width: 1.5,
                  ),
                ),
                child: SalomonBottomBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    context
                        .read<HomeNavCubit>()
                        .changePage(index); // تحديث الحالة

                    pageController.jumpToPage(index);
                  },
                  selectedItemColor: _activeColors[currentIndex],
                  unselectedItemColor: Colors.grey[400],
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  itemPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  items: _navIcons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final icon = entry.value;
                    return SalomonBottomBarItem(
                      icon: Icon(icon, size: 26),
                      title: Text(
                        botomBarHomeTitles(index),
                        style: const TextStyle(fontSize: 12),
                      ),
                      selectedColor: _activeColors[index],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
