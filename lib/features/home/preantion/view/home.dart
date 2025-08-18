import 'package:flutter/material.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_appbar.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_botom_nav_bar.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_drawer.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_select_source_and_dist_on_map.dart';
import 'package:sharecars/features/trip_me/presantion/view/trip_me_list.dart';
import 'package:sharecars/features/trip_search/presantion/view/trip_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: HomeDrawer()),
      appBar: const HomeAppBard(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          TripSelectSourceAndDistOnMap(),
          TripSearch(), // لم يعد هناك BlocProvider هنا
          TripMeList(), // ولم يعد هناك BlocProvider هنا
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(pageController: _pageController),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
