import 'package:sharecars/core/api/api_end_points.dart';

class StartConversationModel {
  final bool success;
  final ConversationData data;

  StartConversationModel({
    required this.success,
    required this.data,
  });

  factory StartConversationModel.fromJson(Map<String, dynamic> json) {
    return StartConversationModel(
      success: json[ApiKey.success] as bool,
      data: ConversationData.fromJson(json[ApiKey.data]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.success: success,
      ApiKey.data: data.toJson(),
    };
  }
}

class ConversationData {
  final int conversationId;
  final String message;

  ConversationData({
    required this.conversationId,
    required this.message,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json[ApiKey.conversationid] as int,
      message: json[ApiKey.message] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
  ApiKey.conversationid: conversationId,
      ApiKey.message: message,
    };
  }
}
