
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharecars/core/errors/excptions.dart';
import 'package:sharecars/core/errors/filuar.dart';
import 'package:sharecars/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:sharecars/features/chat/data/model/all_conversations.dart';
import 'package:sharecars/features/chat/data/model/message.dart';
import 'package:sharecars/features/chat/data/model/start_convresations.dart';
import 'package:sharecars/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ConversationsRemoteDataSource remoteDataSource;
  
  ChatRepoImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Filuar, StartConversationModel>> startConversation(String userId) async {
    try {
      final result = await remoteDataSource.startconversation(userId);
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Filuar, AllConversationsModel>> getAllConversations() async {
    try {
      final result = await remoteDataSource.getallconversations();
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Filuar, MessageListResponse>> getAllMessages(String conversationId) async { // Fixed: Return MessageListResponse
    try {
      final result = await remoteDataSource.getallmessages(conversationId);
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Filuar, MessageModel>> deleteMessage(String messageId) async {
    try {
      final result = await remoteDataSource.deletmessages(messageId);
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Filuar, MessageModel>> sendTextMessage(String type, String content, String conversationId) async {
    try {
      final result = await remoteDataSource.sendtextmessage(type, content, conversationId);
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Future<Either<Filuar, MessageModel>> sendImageMessage(String type, String caption, String conversationId, XFile? image) async {
    try {
      final result = await remoteDataSource.sendimagemessage(type, caption, conversationId, image);
      return right(result);
    } on ServerExpcptions catch (e) {
      return left(e.error);
    } catch (e) {
      return left(Filuar(message: 'Unexpected error: $e'));
    }
  }
  
  @override
  Stream<MessageListResponse> watchMessages(String conversationId) { // Fixed: Return MessageListResponse
    return remoteDataSource.watchMessages(conversationId);
  }
  
  @override
  Stream<AllConversationsModel> watchConversations() {
    return remoteDataSource.watchConversations();
  }
}