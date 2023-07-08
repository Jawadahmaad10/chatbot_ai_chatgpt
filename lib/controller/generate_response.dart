import 'package:chatbot_app/constant/api_key.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateResponse(String prompt) async {
  const apiKey = apikey;

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

//decode
  if (response.statusCode == 200) {
    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];
  }

  return {
    "error": "Cannot catch data",
    "statusCode": response.statusCode,
  }.toString();
}
