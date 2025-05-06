

import 'dart:convert';

import 'package:citizen_app/config/env_config/env_config.dart';
import 'package:citizen_app/config/services/http_service.dart';
import 'package:dio/dio.dart';

import '../../constants/prompts.dart';

class AiService extends HttpService{

  //make the call to get the trivia questions
  Future<Response> getTriviaQuestions({String? specieName, String? occupation}) async {
    String prompt = Prompts.triviaQuestions(specieName: specieName, occupation: occupation);
    print(prompt);
    var body = {
      "contents":[{"parts": [{"text": prompt}]}]
    };
    var response = await post("key=${EnvConfig.geminiApiKey}", body: body);
    return response;
  }

  /// make a call to get the detail trivia of the species
  Future<Response> getMoreInfo({String? specieName}) async {
    String prompt = Prompts.moreInfo(specieName: specieName);
    //print(prompt);
    var body = {
      "contents":[{"parts": [{"text": prompt}]}]
    };
    var response = await post("key=${EnvConfig.geminiApiKey}", body: body);
    return response;
  }

  //gemini json extractor

  static Map<String, dynamic>? extractJson(Map<String, dynamic> geminiResponse) {
    try {
      // Navigate to the text content in the response structure
      if (geminiResponse.containsKey('candidates') &&
          geminiResponse['candidates'] is List &&
          geminiResponse['candidates'].isNotEmpty) {

        final candidate = geminiResponse['candidates'][0];

        if (candidate.containsKey('content') &&
            candidate['content'].containsKey('parts') &&
            candidate['content']['parts'] is List &&
            candidate['content']['parts'].isNotEmpty) {

          final part = candidate['content']['parts'][0];

          if (part.containsKey('text')) {
            final String text = part['text'];
            return _parseTextContent(text);
          }
        }
      }

      return null;
    } catch (e) {
      print('Error extracting JSON from Gemini response: $e');
      return null;
    }
  }

  /// Helper method to parse different text content formats
  static Map<String, dynamic>? _parseTextContent(String text) {
    // Try to extract JSON from code blocks first
    final codeBlockRegex = RegExp(r'```(?:json)?\n([\s\S]*?)\n```');
    final match = codeBlockRegex.firstMatch(text);

    if (match != null && match.groupCount >= 1) {
      final jsonString = match.group(1)?.trim();
      if (jsonString != null) {
        try {
          return jsonDecode(jsonString) as Map<String, dynamic>;
        } catch (e) {
          print('Failed to parse JSON from code block: $e');
        }
      }
    }

    // If no code block or parsing failed, try parsing the text directly
    try {
      return jsonDecode(text) as Map<String, dynamic>;
    } catch (e) {
      // If direct parsing fails, try to find JSON-like structures in the text
      final jsonPattern = RegExp(r'(\{[\s\S]*\})');
      final jsonMatch = jsonPattern.firstMatch(text);

      if (jsonMatch != null && jsonMatch.groupCount >= 1) {
        final potentialJson = jsonMatch.group(1);
        if (potentialJson != null) {
          try {
            return jsonDecode(potentialJson) as Map<String, dynamic>;
          } catch (e) {
            print('Failed to parse JSON from text: $e');
          }
        }
      }
    }

    return null;
  }
}