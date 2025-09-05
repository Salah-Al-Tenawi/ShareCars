import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sharecars/features/chat/data/model/all_conversations.dart';
import 'package:sharecars/features/chat/data/model/start_convresations.dart';
import 'package:sharecars/features/chat/domain/repo/chat_repo.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepo chatRepo;
  StreamSubscription<AllConversationsModel>? _conversationStreamSub;

  ConversationCubit(this.chatRepo) : super(ConversationInitial());

  Future<void> getAllConversations() async {
    emit(ConversationLoading());
    final response = await chatRepo.getAllConversations();
    response.fold(
      (error) => emit(ConversationError(message: error.message)), // fixed
      (result) => emit(AllConversationsLoaded(conversations: result)), // fixed
    );
  }

  Future<void> startConversation(String userId) async {
    emit(ConversationLoading());
    final response = await chatRepo.startConversation(userId);
    response.fold(
      (error) => emit(ConversationError(message: error.message)),
      (result) => emit(StartConversationLoaded(result)),
    );
  }

  void startListeningToConversations(String userId) {
    _conversationStreamSub?.cancel();
    _conversationStreamSub = chatRepo.watchConversations().listen(
      (conversations) {
        emit(AllConversationsLoaded(conversations: conversations));
      },
      onError: (error) {
        emit(ConversationError(message: error.toString()));
      },
    );
  }

  void stopListening() {
    _conversationStreamSub?.cancel();
  }

  @override
  Future<void> close() {
    _conversationStreamSub?.cancel();
    return super.close();
  }
}
