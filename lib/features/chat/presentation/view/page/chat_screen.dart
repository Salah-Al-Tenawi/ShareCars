// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sharecars/features/chat/data/model/message.dart';
// import 'package:sharecars/features/chat/data/model/all_conversations.dart' hide Sender;
// import 'package:sharecars/features/chat/presentation/manger/messages_cubit/message_cubit.dart';
// import 'package:sharecars/features/chat/presentation/view/widget/chat_input_section.dart';
// import 'package:sharecars/features/chat/presentation/view/widget/message_bubble.dart';

// class ChatScreen extends StatefulWidget {
//   final String conversationId;
//   final SenderChat sender;

//   const ChatScreen({
//     Key? key,
//     required this.conversationId,
//     required this.sender,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<MessageCubit>().getAllMessages(widget.conversationId);
//     context.read<MessageCubit>().startListeningToMessages(widget.conversationId);
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     context.read<MessageCubit>().stopListening();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 16,
//               backgroundImage: widget.sender.avatar != null
//                   ? NetworkImage(widget.sender.avatar!)
//                   : null,
//               child: widget.sender.avatar == null
//                   ? Text(widget.sender.name[0].toUpperCase())
//                   : null,
//             ),
//             const SizedBox(width: 10),
//             Text(widget.sender.name),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<MessageCubit, MessageState>(
//               builder: (context, state) {
//                 if (state is MessageLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is MessageError) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Error: ${state.message}'),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<MessageCubit>().getAllMessages(widget.conversationId);
//                           },
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (state is MessageLoadSuccess) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (_scrollController.hasClients) {
//                       _scrollController.animateTo(
//                         _scrollController.position.maxScrollExtent,
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeOut,
//                       );
//                     }
//                   });

//                   return ListView.builder(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(16),
//                     itemCount: state.messages.length,
//                     itemBuilder: (context, index) {
//                       final message = state.messages[index];
//                       return MessageBubble(
//                         message: message,
//                         isMe: message.sender.id == getCurrentUserId(),
//                         onDelete: () => _deleteMessage(message.id.toString()),
//                       );
//                     },
//                   );
//                 }
//                 return const Center(child: Text('No messages yet'));
//               },
//             ),
//           ),
//           ChatInputSection(
//             controller: _messageController,
//             onSendText: _sendTextMessage,
//             onSendImage: _sendImageMessage,
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendTextMessage() {
//     if (_messageController.text.trim().isNotEmpty) {
//       context.read<MessageCubit>().sendTextMessage(
//         'text',
//         _messageController.text.trim(),
//         widget.conversationId,
//       );
//       _messageController.clear();
//     }
//   }

//   void _sendImageMessage(XFile image, String caption) {
//     context.read<MessageCubit>().sendImageMessage(
//       'image',
//       caption,
//       widget.conversationId,
//       image,
//     );
//   }

//   void _deleteMessage(String messageId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Message'),
//         content: const Text('Are you sure you want to delete this message?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               context.read<MessageCubit>().deleteMessage(messageId);
//               Navigator.of(context).pop();
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   int getCurrentUserId() {
//     return 1; // Placeholder – يجب تعديله حسب النظام المستخدم
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sharecars/features/chat/data/model/all_conversations.dart' hide Sender;
import 'package:sharecars/features/chat/presentation/manger/messages_cubit/message_cubit.dart';
import 'package:sharecars/features/chat/presentation/view/widget/chat_input_section.dart';
import 'package:sharecars/features/chat/presentation/view/widget/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final Participant sender;

  const ChatScreen({
    Key? key,
    required this.conversationId,
    required this.sender,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late MessageCubit _messageCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    _messageCubit = context.read<MessageCubit>();
    _messageCubit.getAllMessages(widget.conversationId);
    _messageCubit.startListeningToMessages(widget.conversationId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageCubit.stopListening(); // استخدام المرجع مباشرة بدون context
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: widget.sender.avatar != null
                  ? NetworkImage(widget.sender.avatar!)
                  : null,
              child: widget.sender.avatar == null
                  ? Text(widget.sender.name[0].toUpperCase())
                  : null,
            ),
            const SizedBox(width: 10),
            Text(widget.sender.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                if (state is MessageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessageError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.message}'),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MessageCubit>().getAllMessages(widget.conversationId);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is MessageLoadSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.sender.id == getCurrentUserId(),
                        onDelete: () => _deleteMessage(message.id.toString()),
                      );
                    },
                  );
                }
                return const Center(child: Text('No messages yet'));
              },
            ),
          ),
          ChatInputSection(
            controller: _messageController,
            onSendText: _sendTextMessage,
            onSendImage: _sendImageMessage,
          ),
        ],
      ),
    );
  }

  void _sendTextMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<MessageCubit>().sendTextMessage(
        'text',
        _messageController.text.trim(),
        widget.conversationId,
      );
      _messageController.clear();
    }
  }

  void _sendImageMessage(XFile image, String caption) {
    context.read<MessageCubit>().sendImageMessage(
      'image',
      caption,
      widget.conversationId,
      image,
    );
  }

  void _deleteMessage(String messageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MessageCubit>().deleteMessage(messageId);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  int getCurrentUserId() {
    return 1; // Placeholder – يجب تعديله حسب النظام المستخدم
  }
}
