import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:locall/common/widgets/custom_text_field.dart';
import 'package:locall/common/widgets/primary_button.dart';
import 'package:locall/features/authentication/controllers/login_screen_controller.dart';
import 'package:locall/routes/app_routes.dart';
import 'package:locall/utils/localisation/app_locale.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginScreenController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/open-shop.jpg",
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    const Center(
                      child: Text(
                        "LoCall",
                        style: TextStyle(
                          fontFamily: "Horizon",
                          fontSize: 40,
                          color: Colors.black,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Let`s connect with us!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Form(
                      key: formKey,
                      child: CustomeTextField(
                        controller: loginController.mobileController,
                        label: "Enter mobile number",
                        fieldType: FieldType.mobile,
                        isRequired: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      isEnabled: loginController.isButtonActive,
                      label: AppLocale.login.getString(context),
                      onTap: () {
                        if (formKey.currentState!.validate() &&
                            loginController.isButtonActive.value) {
                          loginController.getUserStatus(
                            onUserFound: () {},
                            onUserNotFound: () {
                              Get.toNamed(AppRoutes.registerUserScreen);
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
