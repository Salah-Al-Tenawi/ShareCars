import 'package:flutter/material.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/class/format_date_time.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(width: 0.5, color: MyColors.accent)),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TripHeader(trip: trip),
              const SizedBox(height: 16),
              _RouteSection(trip: trip),
              const SizedBox(height: 16),
              _TripDetailsGrid(trip: trip),
              const SizedBox(height: 12),
              _TripActionButton(onTap: onTap, onCancel: onCancel),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for trip header (Driver info and status)
class _TripHeader extends StatelessWidget {
  final TripModel trip;

  const _TripHeader({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: MyColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 20, color: MyColors.primary),
            ),
            const SizedBox(width: 8),
            Text(
              trip.driver.name,
              style: TextStyles.title,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: trip.status == 'full'
                ? MyColors.accent.withOpacity(0.15)
                : MyColors.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            trip.status == 'full' ? 'مكتملة' : 'متاحة',
            style: TextStyle(
              color: trip.status == 'full' ? MyColors.accent : MyColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

// Widget for route information
class _RouteSection extends StatelessWidget {
  final TripModel trip;

  const _RouteSection({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColors.primaryBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _LocationRow(
            icon: Icons.circle,
            iconColor: MyColors.primary,
            text: trip.pickup.address,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.more_vert,
                size: 20, color: MyColors.primary.withOpacity(0.3)),
          ),
          _LocationRow(
            icon: Icons.location_pin,
            iconColor: MyColors.accent,
            text: trip.destination.address,
          ),
        ],
      ),
    );
  }
}

// Reusable location row widget
class _LocationRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _LocationRow({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyles.subtitle,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

class _TripDetailsGrid extends StatelessWidget {
  final TripModel trip;

  const _TripDetailsGrid({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRemainingTimeSection(),
        const SizedBox(height: 16),

        // تفاصيل الرحلة في شكل Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            _TripDetailItem(
              icon: Icons.calendar_today,
              title: 'التاريخ',
              value: DateTimeUtils.formatDate(trip.departure),
              color: MyColors.primary,
            ),
            _TripDetailItem(
              icon: Icons.access_time,
              title: 'الوقت',
              value: DateTimeUtils.formatTime(trip.departure),
              color: MyColors.primary,
            ),
            _TripDetailItem(
              icon: Icons.event_seat,
              title: 'المقاعد',
              value: "${trip.seatsAvailable} متاح / ${trip.seatsBooked} محجوز",
              color: MyColors.accent,
            ),
            _TripDetailItem(
              icon: Icons.attach_money,
              title: 'السعر',
              value: "${trip.pricePerSeat} ل.س للمقعد",
              color: Colors.amber[700]!,
            ),
            _TripDetailItem(
              icon: Icons.directions_car,
              title: 'المسافة',
              value: "${trip.distance.kilometers} كم",
              color: MyColors.primary,
            ),
            _TripDetailItem(
              icon: Icons.timer,
              title: 'المدة',
              value: "${trip.duration.minutes} دقيقة",
              color: MyColors.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRemainingTimeSection() {
    final remainingTime = DateTimeUtils.getRemainingTime(trip.departure);
    final isExpired = remainingTime == 'الرحلة انتهت';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: isExpired
            ? MyColors.primaryText
            : MyColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isExpired ? Icons.warning_amber_rounded : Icons.timer_outlined,
            color: isExpired ? MyColors.accent : MyColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpired ? 'انتهت الرحلة' : 'الوقت المتبقي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isExpired ? Colors.orange : MyColors.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                remainingTime,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isExpired ? Colors.orange : MyColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _TripDetailItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        // borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.15),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: MyColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _TripActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  const _TripActionButton({this.onTap, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.primary.withOpacity(0.08),
        ),
        child: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'details' && onTap != null) onTap!();
            if (value == 'cancel' && onCancel != null) onCancel!();
          },
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: 'details',
              child: _PopupMenuRow(
                icon: Icons.info_outline,
                color: MyColors.primary,
                text: 'تفاصيل الرحلة',
              ),
            ),
            const PopupMenuItem(
              value: 'cancel',
              child: _PopupMenuRow(
                icon: Icons.cancel_outlined,
                color: Colors.red,
                text: 'إلغاء الرحلة',
              ),
            ),
          ],
          child: const _ButtonContent(),
        ),
      ),
    );
  }
}

// Widget for popup menu row
class _PopupMenuRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _PopupMenuRow({
    required this.icon,
    required this.color,
    required this.text,
  });

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

// Widget for button content
class _ButtonContent extends StatelessWidget {
  const _ButtonContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'خيارات',
            style: TextStyle(
              color: MyColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.arrow_drop_down, color: MyColors.primary),
        ],
      ),
    );
  }
}

// Text styles collection
class TextStyles {
  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: MyColors.primaryText,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: MyColors.primaryText,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle detail = TextStyle(
    fontSize: 13,
    color: MyColors.primaryText,
  );
}

// Colors collection
