

import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:citizen_app/utils/utils.dart';
import 'package:dio/dio.dart';

class AIVm extends BaseProvider {

  //make the call that gets the trivia
  getTrivia(String speciesName, String occupation) async {
    setUiState(UiState.loading);
    try{
      Response response = await ai.getTriviaQuestions(specieName: speciesName, occupation: occupation);
      var responseBody = response.data;
      if(response.statusCode == 200){
        print(response);
      }
      setUiState(UiState.done);
    } on DioException catch(e) {
      setUiState(UiState.done);

    }
  }

  //this is the call that gets the animal description
  getAnimalDescription(String name) async {
    setUiState(UiState.loading);
    try{
      Response response = await ai.getMoreInfo(specieName: name);
      var responseBody = response.data;
      if(response.statusCode == 200){
        print(Utils.extractMessageMapFromJson(responseBody.toString()));
      }
      setUiState(UiState.done);
    } on DioException catch(e) {
      setUiState(UiState.done);

    }
  }
}