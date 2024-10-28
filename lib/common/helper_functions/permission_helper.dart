import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    }
    openAppSettings();
    return false;
  }

  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }
    openAppSettings();
    return false;
  }

  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    }
    openAppSettings();
    return false;
  }
}
