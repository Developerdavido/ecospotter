

import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_colors.dart';

class ImageService {

  final ImagePicker picker = ImagePicker();
  //capture image
  Future<XFile?> captureImage({required ImageSource source, double? maxHeight, double? maxWidth, int? imageQuality}) async {
    var image = await picker.pickImage(source: source, maxHeight: maxHeight, maxWidth: maxWidth, imageQuality: imageQuality);
    return image;
  }

  //crop image
  Future<CroppedFile?> cropPickedImage({String? toolbarTitle, File? imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: toolbarTitle,
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: AppColors.lime,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
        IOSUiSettings(
          title: toolbarTitle,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
      ],
    );
    return croppedFile;
  }
}