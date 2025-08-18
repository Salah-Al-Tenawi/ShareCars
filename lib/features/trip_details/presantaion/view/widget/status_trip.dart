import 'package:flutter/material.dart';
import 'package:sharecars/core/them/my_colors.dart';

class StatusInfo {
  final String text;
  final Color color;

  StatusInfo(this.text, this.color);
}

StatusInfo getStatusInfo(String? status) {
  final normalized = status?.trim().toLowerCase() ?? "";

  switch (normalized) {
    case 'pending':
      return StatusInfo('قيد الانتظار', MyColors.accent);
    case 'confirmed':
      return StatusInfo('مؤكد', MyColors.primary);
    case 'cancelled':
      return StatusInfo('ملغي', const Color(0xFFDC3545));
    case 'no_show':
      return StatusInfo('لم يحضر', MyColors.secondary);
    case 'completed':
      return StatusInfo('مكتمل', const Color(0xFF28A745));
    case 'full':
      return StatusInfo('ممتلئة', MyColors.primaryBackground);
    case 'active':
      return StatusInfo('متاح', MyColors.primaryBackground);
    default:
      return StatusInfo('غير معروف', MyColors.primaryText);
  }
}

