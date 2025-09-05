import 'package:flutter/material.dart';
import 'package:sharecars/features/chat/data/model/message.dart';

class MessageBubble extends StatelessWidget {
  final MessageData message;
  final bool isMe;
  final VoidCallback onDelete;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.blue[200] : Colors.grey[300];
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: align,
        children: [
          GestureDetector(
            onLongPress: onDelete,
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: radius,
              ),
              padding: const EdgeInsets.all(12),
              child: _buildMessageContent(),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatTimestamp(message.createdAt),
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    if (message.type == 'text') {
      return Text(
        message.content,
        style: const TextStyle(fontSize: 16),
      );
    } else if (message.type == 'image') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(
          //   // message.imageUrl ?? '',
          //   width: 200,
          //   height: 200,
          //   fit: BoxFit.cover,
          //   errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          // ),
          if (message.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14),
              ),
            ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';

    return '${date.day}/${date.month}/${date.year}';
  }
}
