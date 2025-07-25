import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/service/locator_ser.dart';
import 'package:sharecars/features/home/preantion/manger/cubit/home_nav_cubit_cubit.dart';
import 'package:sharecars/features/maps/presantion/manger/push_ride_map/map_cubit.dart';
import 'package:sharecars/features/profiles/data/date_source/profile_remote_date_source.dart';
import 'package:sharecars/features/splash_view/presentaion/manger/cubit/splash_view_cubit.dart';
import 'package:sharecars/features/test/my_test.dart';
import 'package:sharecars/features/auth/data/repo/auth_repo_im.dart';
import 'package:sharecars/features/auth/presentation/manger/forget_password_cubit/forget_password_cubit.dart';
import 'package:sharecars/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:sharecars/features/auth/presentation/manger/singin_cubit/singin_cubit.dart';
import 'package:sharecars/features/auth/presentation/view/forget_password.dart';
import 'package:sharecars/features/auth/presentation/view/login.dart';
import 'package:sharecars/features/auth/presentation/view/singin.dart';
import 'package:sharecars/features/home/preantion/view/home.dart';
import 'package:sharecars/features/maps/push_ride_map.dart';
import 'package:sharecars/features/profiles/data/repo/profile_repo_im.dart';
import 'package:sharecars/features/profiles/presantaion/manger/profile_cubit.dart';
import 'package:sharecars/features/profiles/presantaion/view/profile.dart';
import 'package:sharecars/features/splash_view/presentaion/view/splash_view.dart';
import 'package:sharecars/features/trip_create/data/data_source/trip_create_remote_data_source.dart';
import 'package:sharecars/features/trip_create/data/repo/trip_create_repo_im.dart';
import 'package:sharecars/features/trip_create/presantion/manger/cubit/push_ride_cubit.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_add_number_phone.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_select_date_and_seats.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_select_price_and_booking_type.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_select_source_and_dist_on_map.dart';
import 'package:sharecars/features/trip_create/presantion/view/trip_did_you_back.dart';
import 'package:sharecars/features/vieryfiy_user/presintion/manger/cubit/verfiy_user_cubit.dart';
import 'package:sharecars/features/vieryfiy_user/presintion/view/verfiy_profile.dart';

List<GetPage<dynamic>> appRoute = [
  GetPage(
    name: RouteName.splashView,
    page: () => BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    ),
  ),
  GetPage(name: RouteName.test, page: () => const MyTest()),
  GetPage(
    name: RouteName.login,
    page: () => BlocProvider(
      create: (context) => LoginCubit(getit.get<AuthRepoIm>()),
      child: const Login(),
    ),
  ),
  GetPage(
      name: RouteName.singin,
      page: () => BlocProvider(
            create: (context) => SinginCubit(getit.get<AuthRepoIm>()),
            child: const Singin(),
          )),
  GetPage(
    name: RouteName.forgetpassword,
    page: () => BlocProvider(
      create: (context) => ForgetPasswordCubit(getit.get<AuthRepoIm>()),
      child: const ForgetPassword(),
    ),
  ),
  GetPage(
      name: RouteName.profile,
      page: () => BlocProvider(
            create: (context) => ProfileCubit(ProfileRepoIm(
                profileRemoteDateSourceIm:
                    ProfileRemoteDateSourceIm(api: getit.get<DioConSumer>()))),
            child: const Profile(),
          )),

// verfiy user
// GetPage(name: RouteName.verfiyUser, page: () => BlocProvider(
//             create: (context) => VerfiyUserCubit(),
//             child: const VerfiyProfile(),
//           )) ,
  // map
  GetPage(
    name: RouteName.pushRideMap,
    page: () => BlocProvider(
      create: (_) => MapCubit(),
      child: const PushRideMap(),
    ),
  ),

  // trips create
  // Todo add bloc provider
  GetPage(
      name: RouteName.tripSelectSourceAndDistOnMap,
      page: () => const TripSelectSourceAndDistOnMap()),

  GetPage(
      name: RouteName.tripSelectDateAndSeats,
      page: () => const TripSelectDateAndSeats()),

  GetPage(
      name: RouteName.tripSelectPriceAndBookingType,
      page: () => const TripSelectPriceAndBookingType()),

  GetPage(
    name: RouteName.tripAddNumberPhone,
    page: () => BlocProvider(
      create: (context) => PushRideCubit(
        TripCreateRepoIm(
          tripCreateRemoteDataSource: TripCreateRemoteDataSource(
            api: getit.get<DioConSumer>(),
          ),
        ),
      ),
      child: const TripAddNumberPhone(),
    ),
  ),

  GetPage(name: RouteName.tripDidYouBack, page: () => const TripDidYouBack()),

  // home

  GetPage(
  name: RouteName.home,
  page: () => MultiBlocProvider(
    providers: [
      BlocProvider<HomeNavCubit>(create: (_) => HomeNavCubit()),
      // BlocProvider<AnotherCubit>(create: (_) => AnotherCubit()), // إن احتجت المزيد
    ],
    child: const Home(),
  ),
),];
