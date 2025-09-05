part of 'conversation_cubit.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object?> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class AllConversationsLoaded extends ConversationState {
  final AllConversationsModel conversations;

  const AllConversationsLoaded({required this.conversations});

  @override
  List<Object?> get props => [conversations];
}

class StartConversationLoaded extends ConversationState {
  final StartConversationModel conversation;

  const StartConversationLoaded(this.conversation);

  @override
  List<Object?> get props => [conversation];
}

class ConversationError extends ConversationState {
  final String message;

  const ConversationError({required this.message});

  @override
  List<Object?> get props => [message];
}
