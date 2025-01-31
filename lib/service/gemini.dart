import 'dart:convert';
import 'dart:developer';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:get/get.dart';

class GemController extends GetxController {
  late GenerativeModel myModel;
  initApi() {
    myModel =
        FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash');
  }

  Future<String?> translate(String input, String lang) async {
    // Provide a prompt that contains text
    final prompt = [
      Content.text(
          'detect the language of this text $input and translate it to $lang. use this format "Mo fe jeun ", return the response in jsonFormat {"result":"I want to eat"}')
    ];

// To generate text output, call generateContent with the text input
    final response = await myModel.generateContent(prompt);
    log("${response.text}");
    // Decode JSON string
    Map<String, dynamic> jsonData = json.decode(
        response.text!.replaceAll("`", "").replaceAll("json", "") ?? "");

    // Extract the result value
    String result = jsonData['result'];
    log("mikkkkkkkkkkkkkkkkkk${result}");

    return response.text;
  }
}
