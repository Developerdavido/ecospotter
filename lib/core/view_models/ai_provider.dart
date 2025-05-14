

import 'dart:convert';
import 'dart:developer';

import 'package:citizen_app/config/services/ai_service.dart';
import 'package:citizen_app/core/data/models/trivia_model.dart';
import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:citizen_app/utils/utils.dart';
import 'package:dio/dio.dart';

class AIVm extends BaseProvider {

  Map<String,dynamic>? animalDescription;

  TriviaModel? trivia;

  //make the call that gets the trivia
  getTrivia(String speciesName, String occupation) async {
    setUiState(UiState.loading);
    try{
      Response response = await ai.getTriviaQuestions(specieName: speciesName, occupation: occupation);
      var responseBody = response.data;
      setUiState(UiState.done);
      if(response.statusCode == 200){
        Map<String,dynamic>? geminiResponse = AiService.extractJson(responseBody);
        trivia = TriviaModel.fromJson(geminiResponse!);
      }
    } on DioException catch(e) {
      dialog.showSnackBar("Error fetching questions", "$e");
      setUiState(UiState.done);

    }
  }

  //this is the call that gets the animal description
  Future<Map<String,dynamic>?>? getAnimalDescription(String name) async {
    Map<String,dynamic>? descMap;
    setUiState(UiState.loading);
    try{
      Response response = await ai.getMoreInfo(specieName: name);
      setUiState(UiState.done);
      var responseBody = response.data;
      if(response.statusCode == 200){
        Map<String,dynamic>? geminiResponse = AiService.extractJson(responseBody);
        descMap = Map.from(geminiResponse!);
      }
      return descMap;
    } on DioException catch(e) {
      dialog.showSnackBar("Error fetching animal description", "$e");
      setUiState(UiState.done);
      return descMap;
    }
  }

  //update user points and badges
 Future<bool> updateUserPoints(String userId, int points) async {
    setUiState(UiState.loading);
    try{
      bool success = await badgeService.updateUserPoints(userId, points);
      setUiState(UiState.done);
      return success;
    } on DioException catch(e) {
      setUiState(UiState.done);
      return false;
    }
  }

  setAnimalDescriptionToNull(){
    animalDescription = null;
    notifyListeners();
  }

  //get the points for the trivia
  int getPoints(Map<int, String> answers) {
    int points = 0;
    for (var i = 0; i < trivia!.questions.length; i++) {
      if(trivia!.questions[i].correctAnswer == answers[i]){
        points += 2;
      }
    }
    return points;
  }
}