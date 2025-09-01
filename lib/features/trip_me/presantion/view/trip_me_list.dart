// lib/features/trip_me/presentation/view/trip_me_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/functions/show_my_snackbar.dart';
import 'package:sharecars/core/utils/widgets/loading_widget_size_150.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_me/presantion/manger/cubit/trip_me_cubit.dart';
import 'package:sharecars/features/trip_me/presantion/view/widget/trip_item.dart';

class TripMeList extends StatelessWidget {
  const TripMeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TripMeCubit, TripMeState>(
        listener: (context, state) {
          if (state is TripMeErorr) {
            showMySnackBar(context, state.message);
          } else if (state is TripMeCancel) {
            showMySnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is TripMeLoading) {
            return const Center(child: LoadingWidgetSize150());
          } else if (state is TripMeListLoaded) {
            final List<TripModel> trips = state.trips;

            // دالة التحديث
            Future<void> refreshData() async {
              await context.read<TripMeCubit>().getMeTrips();
            }

            return RefreshIndicator(
              onRefresh: refreshData,
              child: trips.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Empty.png',
                                width: 250.w,
                                height: 250.h,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 16.h),
                              const Text(
                                'لا توجد رحلات',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];

                        return ItemTrip(
                          trip: trip,
                          onTap: () {
                            Get.toNamed(RouteName.tripDetails,
                                arguments: trip.id);
                          },
                          onCancel: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                                title: const Row(
                                  children: [
                                    Icon(Icons.warning_amber_rounded,
                                        color: MyColors.accent, size: 28),
                                    SizedBox(width: 8),
                                    Text(
                                      'تأكيد',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                content: const Text(
                                  'هل أنت متأكد من إلغاء الرحلة؟',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          MyColors.secondaryBackground,
                                      foregroundColor: MyColors.primaryText,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                    ),
                                    child: const Text('لا',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.accent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                    ),
                                    child: const Text('نعم',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await context
                                  .read<TripMeCubit>()
                                  .cancelTrip(trip.id);
                            }
                          },
                        );
                      },
                    ),
            );
          } else if (state is TripMeErorr) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<TripMeCubit>().getMeTrips();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        SizedBox(height: 16.h),
                        IconButton(
                          onPressed: () {
                            context.read<TripMeCubit>().getMeTrips();
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: MyColors.accent,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TripMeCubit>().getMeTrips();
            });
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
