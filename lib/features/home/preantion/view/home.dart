import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/service/locator_ser.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/features/home/preantion/manger/cubit/home_nav_cubit_cubit.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_appbar.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_botom_nav_bar.dart';
import 'package:sharecars/features/home/preantion/view/widget/home_drawer.dart';
import 'package:sharecars/features/profiles/data/date_source/profile_remote_date_source.dart';
import 'package:sharecars/features/profiles/data/repo/profile_repo_im.dart';
import 'package:sharecars/features/profiles/presantaion/manger/profile_cubit.dart';
import 'package:sharecars/features/profiles/presantaion/view/profile.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_select_source_and_dist_on_map.dart';
import 'package:sharecars/features/trip_me/presantion/manger/cubit/trip_me_cubit.dart';
import 'package:sharecars/features/trip_me/presantion/view/trip_me_list.dart';

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
      // backgroundColor: MyColors.primaryBackground,
      drawer: const Drawer(child: HomeDrawer()),
      appBar: const HomeAppBard(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const TripSelectSourceAndDistOnMap(),
          const Center(child: Text("Search Page")),
          BlocProvider(
            create: (context) => getit.get<TripMeCubit>(),
            child: const TripMeList(),
          ),
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
