import 'package:chatbot/chat/presentation/chat_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChatScreen(), debugShowCheckedModeBanner: false);
  }
}
