import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locall/common/helper_functions/show_custom_bottom_sheet.dart';
import 'package:locall/common/widgets/custom_appbar.dart';
import 'package:locall/common/widgets/custom_drop_down.dart';
import 'package:locall/common/widgets/custom_text_field.dart';
import 'package:locall/common/widgets/image_upload.dart';
import 'package:locall/common/widgets/primary_button.dart';
import 'package:locall/config/app_service.dart';
import 'package:locall/features/authentication/controllers/registration_screen_controller.dart';
import 'package:locall/features/authentication/widgets/otp_bottom_sheet.dart';
import 'package:locall/routes/app_routes.dart';

class RegistrationScreen extends StatelessWidget {
  final AppService appService;
  const RegistrationScreen({super.key, required this.appService});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<RegistrationScreenController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Register your account"),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Please complete all information to create your account on LoCall",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff959595),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomeTextField(
                          controller: registerController.nameController,
                          label: "Enter your name",
                          isRequired: true,
                          fieldType: FieldType.text,
                          onChanged: (value) {
                            registerController.checkValidation();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomeTextField(
                          controller: registerController.emailController,
                          label: "Enter your email",
                          isRequired: true,
                          fieldType: FieldType.email,
                          onChanged: (value) {
                            registerController.checkValidation();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomDropdown(
                          items: registerController.cityList,
                          onItemSelected: (value) {
                            registerController.selectCity.value = value.id;
                            registerController.checkValidation();
                          },
                          hint: "Select city",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomDropdown(
                          items: registerController.genderList,
                          onItemSelected: (value) {
                            registerController.selectGender.value = value.id;
                            registerController.checkValidation();
                          },
                          hint: "Select gender",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomDropdown(
                          items: registerController.roleList,
                          onItemSelected: (value) {
                            registerController.selectRole.value = value.id;
                            registerController.checkValidation();
                          },
                          hint: "Select role",
                          isRequired: true,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Checkbox(
                                checkColor: Colors.white,
                                activeColor: const Color(0xffc2e969),
                                value: registerController
                                    .isTermConditionAccepted.value,
                                onChanged: (value) {
                                  registerController
                                      .isTermConditionAccepted.value = value!;
                                  registerController.checkValidation();
                                },
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: RichText(
                                text: TextSpan(
                                  text: 'I agree to the ',
                                  style: const TextStyle(
                                    color: Color(0xff959595),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showCustomBottomSheet(
                                            ImageUploadWidget(),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PrimaryButton(
                        isEnabled: registerController.isButtonActive,
                        label: "Next",
                        onTap: () {
                          if (true) {
                            showCustomBottomSheet(
                              OtpBottomSheet(
                                onConfirm: (v) {
                                  Get.toNamed(AppRoutes.registerShopScreen);
                                },
                                onRetry: () {},
                                appService: appService,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
