import 'package:get/get.dart';
import 'package:locall/routes/app_routes.dart';
import 'package:locall/utils/shared_prefs.dart';

class SplashScreenContoller extends GetxController {
  final SharedPrefs prefs;

  SplashScreenContoller({required this.prefs});
  void navigateToPage() async {
    final bool? langSelected = prefs.getValue(SharedPrefs.selectedLanguage);
    if (langSelected == null) {
      Future.delayed(const Duration(seconds: 3), () async {
        await Get.toNamed(AppRoutes.languageScreen);
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    navigateToPage();
  }

  Future<void> setLanguage() async {}
}
