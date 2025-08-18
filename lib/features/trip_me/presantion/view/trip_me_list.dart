// lib/features/trip_me/presentation/view/trip_me_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharecars/core/route/route_name.dart';
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
            if (trips.isEmpty) {
              return const Center(child: Text('لا توجد رحلات'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<TripMeCubit>().getMeTrips();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return ItemTrip(
                    trip: trip,
                    onTap: () {
                      Get.toNamed(RouteName.tripDetails, arguments: index+1);
                    },
                    onCancel: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('تأكيد'),
                          content: const Text('هل أنت متأكد من إلغاء الرحلة؟'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('لا')),
                            ElevatedButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('نعم')),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await context.read<TripMeCubit>().cancelTrip(index);
                      }
                    },
                  );
                },
              ),
            );
          } else if (state is TripMeErorr) {
            return Center(child: Text(state.message));
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
