import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/functions/show_my_snackbar.dart';
import 'package:sharecars/core/utils/widgets/loading_widget_size_150.dart';
import 'package:sharecars/features/trip_booking/presantion/manger/cubit/booking_me_cubit.dart';
import 'package:sharecars/features/trip_booking/presantion/view/widget/booking_item.dart';

class BookingMeList extends StatefulWidget {
  const BookingMeList({super.key});

  @override
  State<BookingMeList> createState() => _BookingMeListState();
}

class _BookingMeListState extends State<BookingMeList> {
  Future<void> _refreshData() async {
    await context.read<BookingMeCubit>().getMyBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookingMeCubit, BookingMeState>(
        listener: (context, state) {
          if (state is BookingMeCanceled) {
            showMySnackBar(context, "تم الغاء الحجز بنجاح");
          }
        },
        builder: (context, state) {
          if (state is BookingMeloading) {
            return const Center(child: LoadingWidgetSize150());
          } else if (state is BookingMeListLoaded) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: state.bookings.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Image.asset(
                              'assets/images/Empty.png',
                              width: 300.w,
                              height: 300.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 16.h),
                            const Text(
                              'لا توجد حجوزات',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.bookings.length,
                      itemBuilder: (context, index) {
                        final booking = state.bookings[index];
                        return BookingItem(
                          booking: booking,
                          onTapDetails: () {
                            Get.toNamed(RouteName.tripDetails,
                                arguments: state.bookings[index].rideId);
                          },
                        );
                      },
                    ),
            );
          } else if (state is BookingMeErorr) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("خطأ حاول مجددا"),
                        SizedBox(height: 16.h),
                        IconButton(
                          onPressed: () {
                            context.read<BookingMeCubit>().getMyBooking();
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
              context.read<BookingMeCubit>().getMyBooking();
            });
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
