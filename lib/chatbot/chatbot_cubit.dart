import 'chatbot_message.dart';
import 'chatbot_api_service.dart';

class ChatbotCubit {
  final List<ChatMessage> messages = [];

  void addUserMessage(String text) {
    messages.add(ChatMessage(text: text, isUser: true));
  }

  void addAIMessage(String text) {
    messages.add(ChatMessage(text: text, isUser: false));
  }

  Future<String> getAIResponse(String prompt) async {
    return await ChatbotAPIService.sendMessage(prompt);
  }
}
