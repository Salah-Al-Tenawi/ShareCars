import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sharecars/core/route/route_app.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/service/cubit_observer.dart';
import 'package:sharecars/core/service/locator_ser.dart';
import 'package:sharecars/core/them/them_app.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  locatorService();
  runApp(const ShareCars());
}

class ShareCars extends StatelessWidget {
  const ShareCars({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: GetMaterialApp(
        
        title: "app for share cars with people",
        initialRoute: RouteName.login,
        getPages: appRoute,
        theme: ThemApp.lightThem,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
