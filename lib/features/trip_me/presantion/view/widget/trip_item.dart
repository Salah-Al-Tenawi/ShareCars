import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/class/format_date_time.dart';
import 'package:sharecars/core/utils/functions/get_userid.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_details/presantaion/view/widget/status_trip.dart';

class ItemTrip extends StatelessWidget {
  final TripModel trip;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  const ItemTrip({
    super.key,
    required this.trip,
    this.onTap,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final departure = trip.departure;
    final now = DateTime.now();
    final difference = departure.difference(now);
    final statusInfo = getStatusInfo(trip.status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: MyColors.secondary,
                        backgroundImage: trip.driver.avatar != null
                            ? NetworkImage(trip.driver.avatar!)
                            : null,
                        child: trip.driver.avatar == null
                            ? const Icon(Icons.person,
                                color: MyColors.primaryBackground)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        trip.driver.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: MyColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusInfo.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusInfo.text,
                      style: TextStyle(
                        color: statusInfo.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LocationRowModern(
                      icon: Icons.circle,
                      iconColor: MyColors.primary,
                      text: trip.pickup.address),
                  const SizedBox(height: 6),
                  _LocationRowModern(
                      icon: Icons.location_pin,
                      iconColor: MyColors.accent,
                      text: trip.destination.address),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoChip(
                      icon: Icons.calendar_today,
                      label: DateTimeUtils.formatDate(trip.departure),
                      color: MyColors.secondary),
                  _InfoChip(
                      icon: Icons.access_time,
                      label: DateTimeUtils.formatTime(trip.departure),
                      color: MyColors.secondary),
                  _InfoChip(
                    icon: Icons.event_seat,
                    label: " ${trip.seatsAvailable} | ${trip.seatsBooked}",
                    color: MyColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              trip.driver.id == myid()
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (trip.status == "finished")
                          ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              disabledBackgroundColor: Colors.blueGrey,
                            ),
                            child: const Text(
                              "الرحلة انتهت",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        else if (trip.status == "awaiting_confirmation")
                          ElevatedButton(
                            onPressed: () {
                              // Get.toNamed(RouteName.bookingUserInTrip,
                              //     arguments: trip.booking);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              disabledBackgroundColor: Colors.amber,
                            ),
                            child: const Text(
                              "بانتظار تأكيد الركاب",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.11,
                              ),
                            ),
                          )
                        else if (trip.status == "cancelled")
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade300, // أحمر فاتح
                            ),
                            child: const Text(
                              "ملغية",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          )
                        else
                          difference.inSeconds <= 0
                              ? ButtonFinishRide(context, trip.id)
                              : buildRemainingTime(difference),
                        SizedBox(width: 70.w),
                        if (trip.status == "active")
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'details' && onTap != null) onTap!();
                              if (value == 'cancel' && onCancel != null)
                                onCancel!();
                            },
                            itemBuilder: (_) => [
                              const PopupMenuItem(
                                value: 'details',
                                child: _PopupMenuRowModern(
                                  icon: Icons.info_outline,
                                  color: MyColors.primary,
                                  text: 'تفاصيل الرحلة',
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'cancel',
                                child: _PopupMenuRowModern(
                                  icon: Icons.cancel_outlined,
                                  color: Colors.red,
                                  text: 'إلغاء الرحلة',
                                ),
                              ),
                            ],
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: MyColors.accent.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'خيارات',
                                    style: TextStyle(
                                      color: MyColors.secondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down,
                                      color: MyColors.secondary),
                                ],
                              ),
                            ),
                          ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Align ButtonFinishRide(BuildContext context, int tripId) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(RouteName.tripDetails, arguments: tripId);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accent,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 6,
          shadowColor: MyColors.accent.withOpacity(0.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flag,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8.w),
            Text(
              "إنهاء الرحلة",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showEndTripDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: MyColors.primaryBackground,
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: MyColors.accent, size: 28),
            SizedBox(width: 8.w),
            Text(
              "لقد تمت الرحلة بالفعل ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: MyColors.accent,
              ),
            ),
          ],
        ),
        content: Text(
          "عند التأكيد بإنهاء الرحلة من قبل السائق والمسافرين سيتم تحويل حساب الرحلة من المسافرين الى السائق ",
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black87,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // إلغاء
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(
              "رجوع",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              elevation: 4,
            ),
            child: Text(
              "تأكيد",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class _LocationRowModern extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _LocationRowModern(
      {required this.icon, required this.iconColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MyColors.primaryText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _PopupMenuRowModern extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _PopupMenuRowModern(
      {required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

String formatRemainingTime(Duration duration) {
  if (duration.inDays > 0) {
    return 'متبقي ${duration.inDays} يوم و ${duration.inHours % 24} ساعة';
  } else if (duration.inHours > 0) {
    return 'متبقي ${duration.inHours} ساعة و ${duration.inMinutes % 60} دقيقة';
  } else if (duration.inMinutes > 0) {
    return 'متبقي ${duration.inMinutes} دقيقة';
  } else {
    return 'انتهى الوقت';
  }
}

Widget buildRemainingTime(Duration duration) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.amber.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.access_time, color: Colors.black54, size: 18),
        const SizedBox(width: 6),
        Text(
          formatRemainingTime(duration),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
