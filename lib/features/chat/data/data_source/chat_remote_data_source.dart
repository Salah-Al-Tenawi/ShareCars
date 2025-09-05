
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/core/utils/functions/get_token.dart';
import 'package:sharecars/core/utils/functions/upload_file_to_api.dart';
import 'package:sharecars/features/chat/data/model/all_conversations.dart';
import 'package:sharecars/features/chat/data/model/message.dart';
import 'package:sharecars/features/chat/data/model/start_convresations.dart';

abstract class ConversationsRemoteDataSource {
  final DioConSumer api;
  const ConversationsRemoteDataSource({
    required this.api,
  });

  Future<StartConversationModel> startconversation(String userid);
  Future<AllConversationsModel> getallconversations();
  Future<MessageListResponse> getallmessages(String conversationid); 
  Future<MessageModel> deletmessages(String id);
  Future<MessageModel> sendtextmessage(String type, String content, String conversationid);
  Future<MessageModel> sendimagemessage(String type, String caption, String conversationid, XFile? image);
  

  Stream<MessageListResponse> watchMessages(String conversationId, {Duration interval = const Duration(seconds: 3)}); 
  Stream<AllConversationsModel> watchConversations(  {Duration interval = const Duration(seconds: 5)});
}

class ConversationsRemoteDataSourceIM extends ConversationsRemoteDataSource {
  ConversationsRemoteDataSourceIM({required super.api});

  @override
  Future<StartConversationModel> startconversation(String userid) async {
    final response = await api.post(ApiEndPoint.startconversation,
        data: {ApiKey.userId: userid},
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});
    final conversation = StartConversationModel.fromJson(response);
    return conversation;
  }

  @override
  Future<MessageModel> deletmessages(String id) async {
    final response = await api.delete("${ApiEndPoint.deletmessage}/$id",
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});

        
    return MessageModel.fromJson(response);
  }

  @override
  Future<AllConversationsModel> getallconversations() async {

    final response = await api.get("${ApiEndPoint.getallconversations}",
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});
        print("📦 Raw Response: $response");
    return AllConversationsModel.fromJson(response);
  }

  @override
  Future<MessageListResponse> getallmessages(String conversationid) async { // Fixed: Return MessageListResponse
    final response = await api.get("${ApiEndPoint.message}/$conversationid/messages?page=1",
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});
    return MessageListResponse.fromJson(response); // Fixed: Use MessageListResponse
  }

  @override
  Future<MessageModel> sendtextmessage(String type, String content, String conversationid) async {
    final response = await api.post("${ApiEndPoint.message}/$conversationid/messages",
        data: {ApiKey.type: type, ApiKey.content: content},
        header: {ApiKey.authorization: "Bearer ${mytoken()}"});
    final message = MessageModel.fromJson(response);
    return message;
  }

  @override
  Future<MessageModel> sendimagemessage(String type, String caption, String conversationid, XFile? image) async {
    final response = await api.post("${ApiEndPoint.message}/$conversationid/messages",
        data: {
          ApiKey.type: type,
          ApiKey.image: await uploadFiletoApi(image),
          ApiKey.caption: caption,
        },
        header: {ApiKey.authorization: "Bearer ${mytoken()}"},
        isFomrData: true);
    final message = MessageModel.fromJson(response);
    return message;
  }

  // التنفيذ الفعلي للـ Stream باستخدام Polling للرسائل
  @override
  Stream<MessageListResponse> watchMessages(String conversationId, {Duration interval = const Duration(seconds: 3)}) async* { // Fixed: Return MessageListResponse
    while (true) {
      try {
        final messages = await getallmessages(conversationId);
        yield messages;
      } catch (e) {
        print('Error fetching messages: $e');
      }
      await Future.delayed(interval);
    }
  }

  // إضافة Stream للمحادثات
  @override
  Stream<AllConversationsModel> watchConversations( {Duration interval = const Duration(seconds: 5)}) async* {
    while (true) {
      try {
        final conversations = await getallconversations();
        yield conversations;
      } catch (e) {
        print('Error fetching conversations: $e');
      }
      await Future.delayed(interval);
    }
  }
}