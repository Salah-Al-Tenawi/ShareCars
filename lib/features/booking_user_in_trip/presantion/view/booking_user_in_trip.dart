import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sharecars/core/constant/imagesUrl.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/features/booking_user_in_trip/presantion/manger/cubit/booking_user_in_trip_cubit.dart';
import 'package:sharecars/features/trip_create/data/model/booking_model.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/features/trip_details/presantaion/view/widget/status_trip.dart';

class BookingUserINTrip extends StatefulWidget {
  const BookingUserINTrip({super.key});

  @override
  State<BookingUserINTrip> createState() => _BookingUserINTripState();
}

class _BookingUserINTripState extends State<BookingUserINTrip> {
  late List<BookingModel> usersBooking;

  @override
  void initState() {
    usersBooking = Get.arguments as List<BookingModel>;
    super.initState();
  }

  // 🔹 الصفحة الكاملة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text("الحجوزات", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: usersBooking.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/noBooking.png',
                    width: 300.w,
                    height: 300.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 30.h),
                  const Text(
                    'لا توجد حجوزات بعد ..',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 70.h),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: usersBooking.length,
              itemBuilder: (context, index) =>
                  buildBookingCard(usersBooking[index]),
            ),
    );
  }

  // 🔹 تنسيق التاريخ
  String formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd • HH:mm').format(dt);
    } catch (e) {
      return date;
    }
  }

  // 🔹 لون الحالة

  // 🔹 Avatar
  Widget buildUserAvatar(String? avatar, int userId) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.profile, arguments: userId);
      },
      child: CircleAvatar(
        radius: 28,
        backgroundColor: MyColors.secondaryBackground,
        backgroundImage: avatar != null ? NetworkImage(avatar) : null,
        child: avatar == null
            ? const Icon(Icons.person, size: 32, color: Colors.white)
            : null,
      ),
    );
  }

  // 🔹 Header: الاسم + الحالة
  Widget buildHeader(String name, String status, int userId) {
    return BlocBuilder<BookingUserInTripCubit, BookingUserInTripState>(
      builder: (context, state) {
        String currentStatus = status;

        if (state is BookingUserInTripUpdated) {
          currentStatus = state.newStatus;
        }

        final statusInfo = getStatusInfo(currentStatus);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryText,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusInfo.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusInfo.text,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MyColors.primaryBackground),
              ),
            ),
          ],
        );
      },
    );
  }

  // 🔹 Seats + Price
  Widget buildSeatsAndPrice(int seats, int totalPrice) {
    return Row(
      children: [
        const Icon(Icons.event_seat, size: 18, color: MyColors.secondary),
        const SizedBox(width: 4),
        Text(
          "$seats مقاعد",
          style: const TextStyle(fontSize: 14, color: MyColors.secondary),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.attach_money, size: 18, color: MyColors.accent),
        const SizedBox(width: 4),
        Text(
          "$totalPrice ل.س",
          style: const TextStyle(
            fontSize: 14,
            color: MyColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 🔹 تاريخ الحجز
  Widget buildBookingDate(String date) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 16, color: MyColors.secondary),
        const SizedBox(width: 4),
        Text(
          formatDate(date),
          style: const TextStyle(fontSize: 13, color: MyColors.secondary),
        ),
      ],
    );
  }

  // 🔹 بطاقة الحجز
  Widget buildBookingCard(BookingModel booking) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildUserAvatar(booking.avatar, booking.userId),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(
                          booking.userName, booking.status, booking.userId),
                      const SizedBox(height: 6),
                      buildSeatsAndPrice(booking.seats, booking.totaPrice),
                      const SizedBox(height: 6),
                      buildBookingDate(booking.bookingat),
                      SizedBox(height: 10.h),
                      buildCommincationNumber(booking),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            buildActions(booking),
          ],
        ),
      ),
    );
  }

  Row buildCommincationNumber(BookingModel booking) {
    return Row(
      children: [
        const Icon(Icons.phone, size: 16, color: MyColors.secondary),
        const SizedBox(width: 4),
        Text(
          booking.numberPhone,
          style: const TextStyle(fontSize: 13, color: MyColors.secondary),
        ),
      ],
    );
  }

// 🔹 أزرار القبول/الرفض
  Widget buildActions(BookingModel booking) {
    return BlocBuilder<BookingUserInTripCubit, BookingUserInTripState>(
      builder: (context, state) {
        if (state is BookingUserInTripLoading) {
          return Center(
            child: LottieBuilder.asset(
              ImagesUrl.loadinglottie,
              width: 30,
              height: 30,
            ),
          );
        }

        switch (booking.status) {
          case "pending":
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<BookingUserInTripCubit>().acceptPassanger(
                          booking.id,
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      const Text("قبول", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<BookingUserInTripCubit>().rejectPassanger(
                          booking.id,
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      const Text("رفض", style: TextStyle(color: Colors.white)),
                ),
              ],
            );

          case "confirmed":
            return _statusChip("تم القبول", Colors.green);

          case "cancelled":
            return _statusChip("ملغاة", Colors.red);

          case "no_show":
            return _statusChip("لم يحضر", Colors.orange);

          case "completed":
            return _statusChip("مكتملة", Colors.blue);
          case "active":
            return _statusChip("تم الحجز", Colors.blue);

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _statusChip(String label, Color color) {
    return Align(
      alignment: Alignment.center,
      child: Chip(
        label: Text(label, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
