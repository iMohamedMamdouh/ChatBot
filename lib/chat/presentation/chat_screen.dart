import 'package:chatbot/chat/data/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final _geminiService = GeminiService();

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
    });

    _controller.clear();

    final response = await _geminiService.sendMessage(text);

    setState(() {
      _messages.add({"role": "bot", "text": response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFDFDFDFD),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chat Bot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff582218),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? const Color(0xff582218)
                              : const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : const Color(0xff696969),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/icon/Link.svg",
                            width: 24,
                            height: 24,
                          ),
                        ),
                        hintText: "Enter your message",
                        hintStyle: const TextStyle(color: Color(0xffD1D1D1)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff582218),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/icon/send.svg",
                      width: 20,
                      height: 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
