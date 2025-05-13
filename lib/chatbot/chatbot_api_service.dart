import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotAPIService {
  static const _apiKey = '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'; // Replace with your actual API key
  static const _endpoint = 'https://api.groq.com/openai/v1/chat/completions';

  static Future<String> sendMessage(String prompt) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final content = json['choices'][0]['message']['content'];
      return content.trim();
    } else {
      print('Groq error: ${response.statusCode}, ${response.body}');
      return 'Sorry, something went wrong.';
    }
  }
}
