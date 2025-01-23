

import 'dart:io';

import 'package:citizen_app/core/data/models/capture_model.dart';
import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/ui/views/app_navigation/app_navigation_screen.dart';

class CaptureProvider extends BaseProvider {


  List<CaptureModel> captures = [];

  String? imageUrl;
  String? animalName;
  num? latitude = 0.0;
  num? longitude = 0.0;
  String? animalActivity;
  String? campaignId;


  int currentPage = 0;
  int limit = 30;
  bool hasMore = true;
  bool loadingCaptures = false;
  String? loadingError;
  //get all campaigns
  getAllCapturesForCampaign(String id) async {
    //if loading campaigns is true || the data does not have more then return
    if (loadingCaptures || !hasMore) return;
    try {
      loadingCaptures = true;
      List<Map<String, dynamic>> loadedCaptures =
      await captureData.loadAllPostsForCampaigns(campaignId: id, currentPage: currentPage, limit: limit);
      if(loadedCaptures.isEmpty){
        hasMore = false;
      }else {
        captures = loadedCaptures.map((e) => CaptureModel.fromJson(e)).toList();
        currentPage++;
      }
      loadingError = null;
      updateUi(()=> loadingCaptures = false);
    } on Exception catch (e) {
      updateUi(()=> loadingCaptures = false);
      dialog.showSnackBar("Error", e.toString());
      loadingError = "Cannot load posts now, please try again";
    }
  }

  onRefresh(String id){
    captures.clear();
    hasMore = true;
    currentPage = 0;
    loadingError = null;
    getAllCapturesForCampaign(id);
  }

  //upload captureData
  Future uploadCapture(String userId, String username,) async {
    setUiState(UiState.loading);
    try {
      var imageResponse = await captureData.uploadImage(imageUrl!, userId);
      if (imageResponse.isNotEmpty) {
        // the response for the map will be
        var captureModel = CaptureModel(
            id: "",
            userId: userId,
            specieName: animalName!,
            imageUrl: imageUrl!,
            latitude: latitude!,
            longitude: longitude!,
            animalActivity: animalActivity!,
            animalLocationFeature: "",
            createdAt: DateTime.now(),
            campaignId: campaignId!,
            username: username,
            verificationPoints: 0,
            verified: false,
            favorites: []);
        var captureMap = captureModel.toMap();
        var savedCaptureData = await captureData.saveANewCapture(captureMap);
        if(savedCaptureData.isNotEmpty){
          dialog.showSnackBar(
              "Success", "You have successfully completed saving the captured data");
          Get.offAll(()=> const AppNavigation());
        }
      } else {
        dialog.showSnackBar(
            "Error", "Something went wrong whilst saving data please try again");
      }
      setUiState(UiState.done);
    } on Exception catch (e) {
      dialog.showSnackBar("Error", e.toString());
      setUiState(UiState.done);
    }
  }

  //captureImage
  Future<File?> captureAndCropImage({required ImageSource source}) async {
    File? file;
    setUiState(UiState.loading);
    try{
      XFile? xFile  = await imageService.captureImage(source: source, imageQuality: 70);
      if(xFile != null) {
        var newFile = File(xFile.path);
        CroppedFile? croppedFile = await imageService.cropPickedImage(toolbarTitle: "Animal Image", imageFile: newFile);
        if(croppedFile != null) {
          file = File(croppedFile.path);
          setUiState(UiState.done);
          return file;
        }
      }
      setUiState(UiState.done);
    } on Exception catch(e) {
      setUiState(UiState.done);
      dialog.showSnackBar("Error", e.toString());
    }
    return file;
  }

}