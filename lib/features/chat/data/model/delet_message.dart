import 'package:sharecars/core/api/api_end_points.dart';

class DeleteMessage {
  final bool success;
  final String message;

  DeleteMessage({
    required this.success,
    required this.message,
  });


  factory DeleteMessage.fromJson(Map<String, dynamic> json) {
    return DeleteMessage(
      success: json[ApiKey.success] as bool,
      message: json[ApiKey.message] as String,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      ApiKey.success: success,
      ApiKey.message: message,
    };
  }
}
