import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final chatId = args != null ? args['chatId']?.toString() : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Center(
        child: Text('Chat Screen${chatId != null ? ' (chatId: $chatId)' : ''}'),
      ),
    );
  }
}
