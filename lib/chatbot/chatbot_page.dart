import 'package:flutter/material.dart';
import 'chatbot_cubit.dart';
import 'chatbot_message.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ChatbotCubit _chatbotCubit = ChatbotCubit();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatbotCubit.messages.length,
              itemBuilder: (context, index) {
                final msg = _chatbotCubit.messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    color: msg.isUser ? Colors.blue[100] : Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(msg.text),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Ask a question...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final userInput = _controller.text;
                    if (userInput.isNotEmpty) {
                      setState(() => _chatbotCubit.addUserMessage(userInput));
                      _controller.clear();
                      final reply = await _chatbotCubit.getAIResponse(userInput);
                      setState(() => _chatbotCubit.addAIMessage(reply));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
