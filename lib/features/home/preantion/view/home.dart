import 'package:flutter/material.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/features/e_pay/data/data_source/e_pay_remote_data_source.dart';
import 'package:sharecars/features/e_pay/data/repo/e_pay_repo_im.dart';
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
  final _pageController = PageController(initialPage: 1);
  final EPayRepoIm _epy =
      EPayRepoIm(remoteDataSource: EPayRemoteDataSource(api: DioConSumer()));
  String balance = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: HomeDrawer(scaffoldContext: context)),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: FutureBuilder(
          future: _epy.getBalance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return HomeAppBar(balance: "Loading...");
            } else if (snapshot.hasError) {
              return HomeAppBar(balance: "");
            } else {
              final balanceModel = snapshot.data?.fold(
                (error) => null,
                (balanceModel) => balanceModel,
              );
              return HomeAppBar(balance: balanceModel?.balance ?? "0");
            }
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          TripSelectSourceAndDistOnMap(),
          TripSearch(), // لم يعد هناك BlocProvider هنا
          TripMeList(), // ولم يعد هناك BlocProvider هنا
        ],
      ),
      bottomNavigationBar: ModernBottomNavBar(pageController: _pageController),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: Drawer(child: HomeDrawer(scaffoldContext: context)),
  //     appBar: HomeAppBard(balance: balance,),
  //     body: PageView(
  //       controller: _pageController,
  //       physics: const NeverScrollableScrollPhysics(),
  //       children: const [
  //         TripSelectSourceAndDistOnMap(),
  //         TripSearch(), // لم يعد هناك BlocProvider هنا
  //         TripMeList(), // ولم يعد هناك BlocProvider هنا
  //       ],
  //     ),
  //     bottomNavigationBar: ModernBottomNavBar(pageController: _pageController),
  //   );
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }
}
