import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum FieldType { mobile, pincode, text, email }

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.isRequired = false,
    this.fieldType = FieldType.text,
  });
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool? isRequired;
  final FieldType? fieldType;

  @override
  Widget build(BuildContext context) {
    int? getlength() {
      if (fieldType == FieldType.mobile) {
        return 10;
      }
      if (fieldType == FieldType.pincode) {
        return 6;
      }
      return null;
    }

    TextInputType getTextType() {
      if (fieldType == FieldType.mobile) {
        return TextInputType.phone;
      }
      if (fieldType == FieldType.pincode) {
        return TextInputType.number;
      }
      if (fieldType == FieldType.email) {
        return TextInputType.emailAddress;
      }
      return TextInputType.name;
    }

    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (isRequired! &&
            fieldType == FieldType.mobile &&
            (!GetUtils.isNumericOnly(controller.text.trim()) ||
                controller.text.trim().length != 10)) {
          return "Please enter valid mobile number";
        }
        if (isRequired! &&
            fieldType == FieldType.pincode &&
            (!GetUtils.isNumericOnly(controller.text.trim()) ||
                controller.text.trim().length != 6)) {
          return "Please enter valid pincode";
        }
        if (isRequired! &&
            fieldType == FieldType.email &&
            (!GetUtils.isEmail(controller.text.trim()))) {
          return "Please enter valid email";
        }
        if (isRequired! && controller.text.trim().length < 3) {
          return "This is required field";
        }
        return null;
      },
      keyboardType: getTextType(),
      maxLength: getlength(),
      inputFormatters:
          (fieldType == FieldType.pincode || fieldType == FieldType.mobile)
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefix: fieldType == FieldType.mobile
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Text("+91"),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        counterText: '',
      ),
      style: const TextStyle(fontWeight: FontWeight.w500),
      onChanged: onChanged,
    );
  }
}
