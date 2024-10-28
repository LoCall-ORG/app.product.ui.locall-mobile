import 'package:get/get.dart';
import 'package:locall/config/app_config.dart';
import 'package:locall/services/api_service.dart';
import 'package:locall/utils/shared_prefs.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedPrefs>(() => SharedPrefs(), fenix: true);
    Get.lazyPut<ApiService>(
        () => ApiService(
              appConfig: Get.find<AppConfig>(),
            ),
        fenix: true);
  }
}
