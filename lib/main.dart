import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sharecars/core/route/route_app.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/service/cubit_observer.dart';
import 'package:sharecars/core/service/hive_services.dart';
import 'package:sharecars/core/service/locator_ser.dart';
import 'package:sharecars/core/them/them_app.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  locatorService();
  await HiveService.init();
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
        title: "state mangment with cubit and navigation by getx",
        initialRoute: RouteName.chatListScreen,
        getPages: appRoute,
        theme: ThemApp.lightThem,
        debugShowCheckedModeBanner: false,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
