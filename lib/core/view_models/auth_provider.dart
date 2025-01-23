import 'package:citizen_app/config/services/local_storage_service.dart';
import 'package:citizen_app/config/services/supabase_service.dart';
import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:citizen_app/core/data/models/ranking_model.dart';
import 'package:citizen_app/core/presentation/ui/views/app_navigation/app_navigation_screen.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/add_animal_interested.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/add_profession_screen.dart';
import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/user_model.dart';
import '../presentation/ui/views/auth/views/username_screen.dart';
import 'dart:io';

class AuthProvider extends BaseProvider {
  UserModel? userModel;
  AuthModel? authModel;

  String? profession;
  String? gender;
  List<String> animalsInterested = [];
  String? userName;

  bool gettingUsername = false;

  bool loading = false;

  bool found = false;

  //login the user
  loginUser() async {
    setUiState(UiState.loading);
    try {
      authModel = await auth.loginUser();
      setUiState(UiState.done);
      if (authModel != null) {
        //cache the accessToken
        await CacheHelper.instance.cacheString(
            CacheHelper.accessTokenKey, authModel!.authResponse.session!.accessToken);
        //cache the user id
        await CacheHelper.instance
            .cacheString(CacheHelper.userIdKey, authModel!.authResponse.user!.id);

        //check if the user exists in the db
        List<Map<String, dynamic>> userData =
            await auth.getUserById(authModel!.authResponse.user!.id);
        //if empty go through the username,
        if (userData.isEmpty) {
          Get.offAll(() => const ChooseUsername(), transition: Transition.cupertino);
        } else {
          await CacheHelper.instance.cacheModel(CacheHelper.userModelKey, userData[0]);
          userModel = UserModel.fromJson(userData[0]);
          Get.offAll(() => const AppNavigation(), transition: Transition.cupertino);
        }
        // if not empty save the user model and enter the home screen
      }
    } on Exception catch (e) {
      setUiState(UiState.done);
      dialog.showSnackBar("Error", e.toString());
    }
  }

  //check the username
  Future<bool> isUsernamePresent(String username) async {
    updateUi(() => gettingUsername = true);
    try {
      List<Map<String, dynamic>> data = await auth.getUsername(username);
      updateUi(() => gettingUsername = false);
      if (data.isEmpty) {
        found = true;
        return found;
      }
    } on Exception catch (e) {
      updateUi(() => gettingUsername = false);
      found = false;
      return found;
    }
    return found;
  }

  //check if user exists in the db
  doesUserExistInLocalStorage() async {
    try {
      String? accessToken = CacheHelper.instance.readString(CacheHelper.accessTokenKey);
      //if the access token is not present then it means that the user is a first time user
      if (accessToken == null) return;

      //read the database
      String? userId = CacheHelper.instance.readString(CacheHelper.userIdKey);

      if (userId == null) return;

      //check if the user model is not null
      if (userModel != null) {
        userModel = UserModel.fromJson(await CacheHelper.instance
            .readModel(CacheHelper.userModelKey) as Map<String, dynamic>);
        Get.offAll(() => const AppNavigation(), transition: Transition.cupertino);
        return;
      }

      loading = true;
      List<Map<String, dynamic>> userData = await auth.getUserById(userId);
      updateUi(() => loading = false);

      //if the user data is empty
      if (userData.isEmpty) {
        updateUi(() => loading = false);
        checkForIncompleteProfile();
      } else {
        userModel = UserModel.fromJson(userData[0]);
        await CacheHelper.instance.cacheModel(CacheHelper.userModelKey, userData[0]);
        updateUi(() => loading = false);
        Get.offAll(() => const AppNavigation(), transition: Transition.cupertino);
      }
    } on Exception catch (e) {
      dialog.showSnackBar("Error", e.toString());
      updateUi(() => loading = false);
    }
  }

  //update avatar
  Future<UserModel> updateAvatar(String userId, String imagePath) async {
    setUiState(UiState.loading);
    try {
      var imageResponse = await auth.uploadAvatar(imagePath, userId);
      if (imageResponse.isNotEmpty) {
        var data = {"avatar_url": imageResponse};
        var userData = await auth.updateUser(userId, data);
        await CacheHelper.instance.cacheModel(CacheHelper.userModelKey, userData[0]);
        userModel = UserModel.fromJson(userData[0]);
        Get.back();
      } else {
        dialog.showSnackBar(
            "Error", "Something went wrong whilst saving data please try again");
      }
      setUiState(UiState.done);
      return userModel!;
    } on Exception catch (e) {
      dialog.showSnackBar("Error", e.toString());
      setUiState(UiState.done);
    }
    return userModel!;
  }

  //captureImage
  Future<File?> captureAndCropImage({required ImageSource source}) async {
    File? file;
    setUiState(UiState.loading);
    try{
      XFile? xFile  = await imageService.captureImage(source: source, imageQuality: 50);
      if(xFile != null) {
        var newFile = File(xFile.path);
        CroppedFile? croppedFile = await imageService.cropPickedImage(toolbarTitle: "Avatar image", imageFile: newFile);
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

  //save user in db
  saveUserInDb() async {
    setUiState(UiState.loading);
    UserModel model = UserModel(
        id: authModel!.authResponse.user!.id,
        role: "user",
        sex: gender!,
        points: 0,
        profession: profession,
        avatarUrl: authModel?.photoUrl ?? "",
        displayName: authModel?.displayName ?? "",
        username: userName,
        speciesOfInterest: animalsInterested);
    try {
      List<Map<String, dynamic>> userData = await auth.saveUserToDb(model.toMap());
      if (userData.isNotEmpty) {
        userModel = UserModel.fromJson(userData[0]);
        var leaderboardModel = LeaderboardModel(
          avatar: userModel!.avatarUrl,
          points: userModel!.points as int,
          username: userModel!.username,
        );
        List<Map<String, dynamic>> leaderboards = await leaderboardData.insertUser(leaderboardModel.toMap());
        await CacheHelper.instance.cacheModel(CacheHelper.userModelKey, userData[0]);
        Get.offAll(() => const AppNavigation(), transition: Transition.cupertino);
        clearUserInfo();
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

  //check if user has data pending
  checkForIncompleteProfile() {
    if (animalsInterested.isEmpty) {
      Get.to(() => const AnimalInterestedScreen(), transition: Transition.cupertino);
    } else if (profession == null) {
      Get.to(() => const AddProfessionScreen(), transition: Transition.cupertino);
    } else {
      Get.to(() => const ChooseUsername(), transition: Transition.cupertino);
    }
  }

  void clearUserInfo() {
    profession = null;
    gender = null;
    animalsInterested.clear();
    userName = null;
    notifyListeners();
  }
}
