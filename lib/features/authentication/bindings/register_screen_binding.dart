import 'package:get/get.dart';
import 'package:locall/features/authentication/controllers/registration_screen_controller.dart';
import 'package:locall/services/api_service.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationScreenController>(
      () => RegistrationScreenController(apiService: Get.find<ApiService>()),
    );
  }
}
