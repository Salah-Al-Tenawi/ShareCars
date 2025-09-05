// import 'package:sharecars/core/api/api_end_points.dart';

// class MessageModel {
//   final bool success;
//   final MessageData data;

//   MessageModel({
//     required this.success,
//     required this.data,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       success: json[ApiKey.success],
//       data: MessageData.fromJson(json[ApiKey.data]),
//     );
//   }
// }

// class MessageListResponse {
//   final bool success;
//   final List<MessageData> data;

//   MessageListResponse({
//     required this.success,
//     required this.data,
//   });

//   factory MessageListResponse.fromJson(Map<String, dynamic> json) {
//     return MessageListResponse(
//       success: json[ApiKey.success],
//       data: (json[ApiKey.data] as List)
//           .map((item) => MessageData.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class MessageData {
//   final int id;
//   final int? conversationId; // optional, only available in startMessage
//   final Sender sender;
//   final String type;
//   final String content;
//   final List<dynamic> metadata;
//   final DateTime createdAt;
//   final bool isEdited;

//   MessageData({
//     required this.id,
//     this.conversationId,
//     required this.sender,
//     required this.type,
//     required this.content,
//     required this.metadata,
//     required this.createdAt,
//     this.isEdited = false, // default false if not provided
//   });

//   factory MessageData.fromJson(Map<String, dynamic> json) {
//     return MessageData(
//       id: json[ApiKey.id],
//       conversationId: json[ApiKey.conversationid], // might be null
//       sender: Sender.fromJson(json['sender']),
//       type: json[ApiKey.type],
//       content: json[ApiKey.content],
//       metadata: json[ApiKey.metadata] ?? [],
//       createdAt: DateTime.parse(json[ApiKey.createdAt]),
//       isEdited: json[ApiKey.isedited] ?? false,
//     );
//   }
// }

// class Sender {
//   final int id;
//   final String name;
//   final String? avatar;

//   Sender({
//     required this.id,
//     required this.name,
//     this.avatar,
//   });

//   factory Sender.fromJson(Map<String, dynamic> json) {
//     return Sender(
//       id: json[ApiKey.id],
//       name: json[ApiKey.name],
//       avatar: json['avatar'],
//     );
//   }
// }




// // class APIErrorResponse {
// //   final String message;
// //   final int status;

// //   APIErrorResponse({required this.message, required this.status});

// //   factory APIErrorResponse.fromJson(Map<String, dynamic> json) {
// //     return APIErrorResponse(
// //       message: json['message'],
// //       status: json['status'],
// //     );
// //   }
// // }

import 'package:sharecars/core/api/api_end_points.dart';

// -------------------- MessageModel --------------------

class MessageModel {
  final bool success;
  final MessageData data;

  MessageModel({
    required this.success,
    required this.data,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      success: json[ApiKey.success],
      data: MessageData.fromJson(json[ApiKey.data]),
    );
  }
}



class MessageListResponse {
  final bool success;
  final List<MessageData> data;

  MessageListResponse({
    required this.success,
    required this.data,
  });

  factory MessageListResponse.fromJson(Map<String, dynamic> json) {
    return MessageListResponse(
      success: json[ApiKey.success],
      data: (json[ApiKey.data] as List)
          .map((item) => MessageData.fromJson(item))
          .toList(),
    );
  }
}



class MessageData {
  final int id;
  final int? conversationId;
  final Sender sender;
  final String type;
  final String content;
  final dynamic metadata; // could be List or ImageMetadata
  final DateTime createdAt;
  final bool isEdited;

  MessageData({
    required this.id,
    this.conversationId,
    required this.sender,
    required this.type,
    required this.content,
    required this.metadata,
    required this.createdAt,
    this.isEdited = false,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    dynamic rawMetadata = json[ApiKey.metadata];

    dynamic parsedMetadata;
    if (json[ApiKey.type] == 'image' && rawMetadata is Map<String, dynamic>) {
      parsedMetadata = ImageMetadata.fromJson(rawMetadata);
    } else {
      parsedMetadata = rawMetadata ?? [];
    }

    return MessageData(
      id: json[ApiKey.id],
      conversationId: json[ApiKey.conversationid],
      sender: Sender.fromJson(json['sender']),
      type: json[ApiKey.type],
      content: json[ApiKey.content],
      metadata: parsedMetadata,
      createdAt: DateTime.parse(json[ApiKey.createdAt]),
      isEdited: json[ApiKey.isedited] ?? false,
    );
  }
}


class Sender {
  final int id;
  final String name;
  final String? avatar;

  Sender({
    required this.id,
    required this.name,
    this.avatar,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      avatar: json[ApiKey.avatar],
    );
  }
}


class ImageMetadata {
  final String imageUrl;
  final String imageName;
  final int imageSize;
  final String imageMime;

  ImageMetadata({
    required this.imageUrl,
    required this.imageName,
    required this.imageSize,
    required this.imageMime,
  });

  factory ImageMetadata.fromJson(Map<String, dynamic> json) {
    return ImageMetadata(
      imageUrl: json['image_url'],
      imageName: json['image_name'],
      imageSize: json['image_size'],
      imageMime: json['image_mime'],
    );
  }
}
