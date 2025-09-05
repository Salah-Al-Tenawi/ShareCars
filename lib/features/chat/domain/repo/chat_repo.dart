
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/chat/data/model/all_conversations.dart';
import 'package:sharecars/features/chat/data/model/message.dart';
import 'package:sharecars/features/chat/data/model/start_convresations.dart';

abstract class ChatRepo {
  Future<Either<Filuar, StartConversationModel>> startConversation(String userId);
  Future<Either<Filuar, AllConversationsModel>> getAllConversations();
  Future<Either<Filuar, MessageListResponse>> getAllMessages(String conversationId); 
  Future<Either<Filuar, MessageModel>> deleteMessage(String messageId);
  Future<Either<Filuar, MessageModel>> sendTextMessage(String type, String content, String conversationId);
  Future<Either<Filuar, MessageModel>> sendImageMessage(String type, String caption, String conversationId, XFile? image);

  Stream<MessageListResponse> watchMessages(String conversationId); 
  Stream<AllConversationsModel> watchConversations();
}