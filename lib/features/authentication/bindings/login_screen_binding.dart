import 'package:get/get.dart';
import 'package:locall/features/authentication/controllers/login_screen_controller.dart';
import 'package:locall/services/api_service.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(
      () => LoginScreenController(apiService: Get.find<ApiService>()),
    );
  }
}
