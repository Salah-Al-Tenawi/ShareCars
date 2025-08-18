import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/utils/widgets/loading_widget_size_150.dart';
import 'package:sharecars/features/trip_details/presantaion/manger/cubit/tripdetails_cubit.dart';
import 'package:sharecars/features/trip_details/presantaion/view/widget/body_trip_details.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late final int tripId;

  @override
  void initState() {
    tripId = Get.arguments as int;
    // tripId = 1;
    context.read<TripDetailsCubit>().fetchTrip(tripId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<TripDetailsCubit>().fetchTrip(tripId);
        },
        child: BlocConsumer<TripDetailsCubit, TripDetailsState>(
          listener: (context, state) {
            if (state is TripDetailsGoToProfile) {
              Get.toNamed(RouteName.profile, arguments: state.userId);
            } else if (state is TripDetailsGoToChat) {
              // todo add route name chat
              // todo don't forget that
              // todo
              // Get.toNamed(RouteName.forgetpassword,
              //     arguments: {'userId': state.driverId});
            } else if (state is TripDetailsCancel) {
              Get.snackbar('تم إلغاء الرحلة', state.message,
                  snackPosition: SnackPosition.BOTTOM);
            } else if (state is TripDetailsRequestBooking) {
              Get.snackbar('تم الحجز', 'رقم الطلب: ${state.booking.id}',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          builder: (context, state) {
            if (state is TripDetailsLoading) {
              return const Center(child: LoadingWidgetSize150());
            } else if (state is TripDetailsError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 200),
                  Center(child: Text("خطأ: ${state.message}")),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TripDetailsCubit>().fetchTrip(tripId);
                      },
                      child: const Text("🔄 أعد المحاولة"),
                    ),
                  ),
                ],
              );
            } else if (state is TripDetailsLoaded) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  
                  BodyTripDetails(
                    trip: state.trip,
                    mode: state.mode,
                  ),
                ],
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<TripDetailsCubit>().fetchTrip(tripId);
                },
                child: const Text("🔄 أعد المحاولة"),
              ),
            );
          },
        ),
      ),
    );
  }
}
