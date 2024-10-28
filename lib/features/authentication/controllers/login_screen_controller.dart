import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:locall/common/helper_functions/error_message.dart';
import 'package:locall/features/authentication/models/check_user_response_model.dart';
import 'package:locall/services/api_service.dart';

class LoginScreenController extends GetxController {
  final ApiService apiService;

  LoginScreenController({required this.apiService});

  final mobileController = TextEditingController();

  RxBool isButtonActive = false.obs;

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    mobileController.addListener(() {
      String number = mobileController.text.trim();
      if (GetUtils.isNum(number) && number.length == 10) {
        isButtonActive(true);
      } else {
        isButtonActive(false);
      }
    });
  }

  void getUserStatus(
      {required VoidCallback onUserFound,
      required VoidCallback onUserNotFound}) async {
    try {
      await EasyLoading.show();
      final Map<String, dynamic> payload = {
        "mobile": {
          "countryCode": "+91",
          "number": mobileController.text.trim(),
        }
      };
      final result = await apiService.post("check-user", body: payload);
      final data = CheckUserResponse.fromJson(result);
      if (data.data!.userFound!) {
        onUserFound();
      } else {
        onUserNotFound();
      }
    } catch (e) {
      showError("Something went wrong!");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
