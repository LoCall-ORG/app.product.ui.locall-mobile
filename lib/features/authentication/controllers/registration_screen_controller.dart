import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locall/common/models/item_model.dart';
import 'package:locall/services/api_service.dart';

class RegistrationScreenController extends GetxController {
  final ApiService apiService;

  RegistrationScreenController({required this.apiService});

  final List<ItemModel> cityList = [
    ItemModel(id: "66fab56376d7b419cc5ca83d", name: "Patna"),
    ItemModel(id: "66fab56376d7b419cc5ca83e", name: "Ranchi"),
    ItemModel(id: "66fab56376d7b419cc5ca83f", name: "Dhanbad"),
  ];
  final List<ItemModel> genderList = [
    ItemModel(id: "66fab56376d7b419cc5ca83d", name: "Male"),
    ItemModel(id: "66fab56376d7b419cc5ca83e", name: "Female"),
    ItemModel(id: "66fab56376d7b419cc5ca83f", name: "Others"),
  ];
  final List<ItemModel> roleList = [
    ItemModel(id: "seller", name: "Seller"),
    ItemModel(id: "customer", name: "Customer"),
  ];

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  RxString selectCity = "".obs;
  RxString selectGender = "".obs;
  RxString selectRole = "".obs;
  RxBool isTermConditionAccepted = false.obs;
  RxBool isButtonActive = false.obs;
  bool isNameValid() {
    return nameController.text.trim().length > 2;
  }

  bool isEmailValid() {
    return GetUtils.isEmail(emailController.text.trim()) &&
        emailController.text.trim().isNotEmpty;
  }

  void checkValidation() {
    isButtonActive(false);
    if (isTermConditionAccepted.value &&
        isNameValid() &&
        isEmailValid() &&
        selectCity.isNotEmpty &&
        selectGender.isNotEmpty &&
        selectRole.isNotEmpty) {
      isButtonActive(true);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
