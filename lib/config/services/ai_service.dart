

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
    print(prompt);
    var body = {
      "contents":[{"parts": [{"text": prompt}]}]
    };
    var response = await post("key=${EnvConfig.geminiApiKey}", body: body);
    return response;
  }
}