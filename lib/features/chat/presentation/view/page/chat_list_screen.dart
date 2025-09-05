
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharecars/features/chat/presentation/manger/conversation_cubit/conversation_cubit.dart';
import 'package:sharecars/features/chat/presentation/view/widget/chat_list_tile.dart';
class ChatListScreen extends StatefulWidget {
   ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  
  @override
  void initState() {
    super.initState();
   
    final userId = 3;
    // final userId = Get.arguments as int;
    context.read<ConversationCubit>().getAllConversations();
  }

  @override
  void dispose() {
    context.read<ConversationCubit>().stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      
      ),
      body: BlocBuilder<ConversationCubit, ConversationState>(
        builder: (context, state) {
          if (state is ConversationLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (state is ConversationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                
                ],
              ),
            );
          }
           else if (state is AllConversationsLoaded) {
            return ListView.builder(
              itemCount: state.conversations.data.length,
              itemBuilder: (context, index) {
                final chat = state.conversations.data[index];
                return ChatListTile(chat: chat);
              },
            );
          }
          return const Center(child: Text('No conversations available'));
        },
      ),
    );
  }

 
}
