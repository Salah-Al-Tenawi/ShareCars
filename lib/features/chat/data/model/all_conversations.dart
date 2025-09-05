import 'package:sharecars/core/api/api_end_points.dart';

class AllConversationsModel {
  final bool success;
  final List<ChatData> data;

  AllConversationsModel({required this.success, required this.data});

  factory AllConversationsModel.fromJson(Map<String, dynamic> json) {
    return AllConversationsModel(
      success: json[ApiKey.success],
      data: (json[ApiKey.data] as List)
          .map((item) => ChatData.fromJson(item))
          .toList(),
    );
  }
}

class ChatData {
  final int id;
  final String type;
  final String? title;
  final Participant otherParticipant;
  final LastMessage? lastMessage;
  final DateTime updatedAt;

  ChatData({
    required this.id,
    required this.type,
    this.title,
    required this.otherParticipant,
    this.lastMessage,
    required this.updatedAt,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json[ApiKey.id],
      type: json[ApiKey.type],
      title: json[ApiKey.title],
      otherParticipant: Participant.fromJson(json[ApiKey.otherparticipant]),
      lastMessage: json[ApiKey.lastmessage] != null
          ? LastMessage.fromJson(json[ApiKey.lastmessage])
          : null,
      updatedAt: DateTime.parse(json[ApiKey.updatedat]),
    );
  }
}

class Participant {
  final int id;
  final String name;
  final String? avatar;

  Participant({required this.id, required this.name, this.avatar});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      avatar: json[ApiKey.avatar],
    );
  }
}

class LastMessage {
  final String content;
  final String senderName;
  final String createdAt;

  LastMessage({
    required this.content,
    required this.senderName,
    required this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      content: json[ApiKey.content],
      senderName: json[ApiKey.sendername],
      createdAt: json[ApiKey.createdat],
    );
  }
}
