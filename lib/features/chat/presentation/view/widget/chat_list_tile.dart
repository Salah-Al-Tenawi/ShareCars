import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharecars/core/route/route_name.dart';
import 'package:sharecars/features/chat/data/model/all_conversations.dart';
import 'package:sharecars/features/chat/presentation/view/page/chat_screen.dart';


class ChatListTile extends StatelessWidget {
  final ChatData chat;

  const ChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: CircleAvatar(
        backgroundImage: chat.otherParticipant.avatar != null
            ? NetworkImage(chat.otherParticipant.avatar!)
            : null,
        child: chat.otherParticipant.avatar == null
            ? Text(chat.otherParticipant.name[0].toUpperCase())
            : null,
      ),
      title: Text(
        chat.otherParticipant.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
   subtitle: Text(
  chat.lastMessage?.content ?? 'No messages yet',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
      trailing: Text(
        _formatDate(chat.updatedAt),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
     onTap: () {
  Get.toNamed(
    RouteName.chatScreen,
    arguments: {
      'conversationId': chat.id.toString(),
      'sender': chat.otherParticipant,
    },
  );
}
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}
