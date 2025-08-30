import 'package:flutter/material.dart';
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
              // Header: Driver + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: MyColors.secondary,
                        child: Icon(Icons.person,
                            color: MyColors.primaryBackground),
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
                      color: statusInfo.color.withOpacity(0.15), // لون الخلفية
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusInfo.text, // النص المناسب
                      style: TextStyle(
                        color: statusInfo.color, // لون النص
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Route info
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
              // Trip info: date, time, seats
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
              // Action button
              trip.driver.id == myid()
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: PopupMenuButton<String>(
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
                                color: MyColors.primary, // غيرت اللون هنا
                                text: 'تفاصيل الرحلة',
                              )),
                          const PopupMenuItem(
                              value: 'cancel',
                              child: _PopupMenuRowModern(
                                icon: Icons.cancel_outlined,
                                color: Colors.red, // أو أي لون تريد
                                text: 'إلغاء الرحلة',
                              )),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: MyColors.accent
                                .withOpacity(0.4), // لون الخلفية الجديد
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'خيارات',
                                style: TextStyle(
                                  color: MyColors.secondary, // لون النص الجديد
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down,
                                  color: MyColors.secondary), // لون السهم
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
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
