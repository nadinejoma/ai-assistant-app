import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:translator_plus/translator_plus.dart';

import '../helper/global.dart';

class APIs {
  // Get answer from Google Gemini AI
  static Future<String> getAnswer(String question) async {
    try {
      log('API key: $apiKey');

      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final content = [Content.text(question)];
      final res = await model.generateContent(content, safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
      ]);

      log('Response from Google Gemini: ${res.text}');
      return res.text ?? 'Sorry, I could not generate a response at this time.';
    } catch (e) {
      log('Error in getAnswer from Google Gemini: $e');
      return 'Something went wrong while processing your request. Please try again later.';
    }
  }

  // Analyze sentiment using Google Natural Language API
  static Future<double> analyzeSentiment(String text) async {
    try {
      log('Analyzing sentiment for: $text');

      final response = await post(
        Uri.parse('https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBZPS6nQ-6yiFjDXFEDEJs-iXPFq9rcLc0'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'document': {'type': 'PLAIN_TEXT', 'content': text},
          'encodingType': 'UTF8',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final score = data['documentSentiment']['score'] ?? 0.0;
        log('Sentiment score: $score');
        return score;
      } else {
        log('Error in sentiment analysis: ${response.statusCode}');
        return 0.0; // Neutral fallback
      }
    } catch (e) {
      log('Error in analyzeSentiment: $e');
      return 0.0; // Neutral fallback
    }
  }

  // Search AI-generated images from Lexica
  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      final res = await get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List.from(data['images']).map((e) => e['src'].toString()).toList();
      } else {
        log('Error in Lexica API: Status code ${res.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error in searchAiImages: $e');
      return []; // Return an empty list if the API call fails
    }
  }

  // Translate text using Google Translate API
  static Future<String> googleTranslate({
    required String from,
    required String to,
    required String text,
  }) async {
    try {
      log('Translating text from $from to $to: $text');

      final res = await GoogleTranslator().translate(text, from: from, to: to);

      log('Translation result: ${res.text}');
      return res.text ?? 'Translation failed.';
    } catch (e) {
      log('Error in googleTranslate: $e');
      return 'Something went wrong during translation.';
    }
  }
}




