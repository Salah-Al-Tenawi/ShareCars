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
      return StatusInfo('قيد الانتظار', const Color(0xFFFFA500)); // برتقالي
    case 'confirmed':
      return StatusInfo('مؤكد', const Color(0xFF007BFF)); // أزرق
    case 'cancelled':
      return StatusInfo('ملغي', const Color(0xFFDC3545)); // أحمر
    case 'no_show':
      return StatusInfo('لم يحضر', const Color(0xFF6C757D)); // رمادي
    case 'completed':
      return StatusInfo('مكتمل', const Color(0xFF28A745)); // أخضر
    case 'full':
      return StatusInfo('ممتلئة', MyColors.primaryBackground); // بنفسجي
    case 'active':
      return StatusInfo('متاح ', MyColors.primaryBackground); // بنفسجي
    default:
      return StatusInfo('غير معروف', const Color(0xFF343A40)); // أسود رمادي
  }
}
