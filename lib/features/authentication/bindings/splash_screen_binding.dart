import 'package:get/get.dart';
import 'package:locall/features/authentication/controllers/splash_screen_contoller.dart';
import 'package:locall/utils/shared_prefs.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenContoller>(
        () => SplashScreenContoller(prefs: Get.find<SharedPrefs>()));
  }
}
