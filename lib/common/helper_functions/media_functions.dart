import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locall/common/helper_functions/permission_helper.dart';

enum PictureSource { camera, gallery }

class AssetModel {
  final String name;
  final String type;
  final Uint8List data;

  AssetModel({required this.name, required this.type, required this.data});
}

Future<AssetModel?> getImage(PictureSource source) async {
  final bool permissionGranter =
      await PermissionHelper.requestCameraPermission();
  if (!permissionGranter) return null;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  if (source == PictureSource.camera) {
    image = await picker.pickImage(source: ImageSource.camera);
  } else {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  if (image != null) {
    CroppedFile? croppedFile =
        await ImageCropper().cropImage(sourcePath: image.path);
    if (croppedFile != null) {
      return AssetModel(
        name: image.name,
        type: image.mimeType ?? 'image/jpeg',
        data: await croppedFile.readAsBytes(),
      );
    }
  }
  return null;
}
