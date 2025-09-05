part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoadSuccess extends MessageState {
  final List<MessageData> messages;

  const MessageLoadSuccess({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class MessageSendSuccess extends MessageState {}

class MessageError extends MessageState {
  final String message;

  const MessageError({required this.message});

  @override
  List<Object?> get props => [message];
}