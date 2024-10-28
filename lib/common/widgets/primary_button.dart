import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final RxBool isEnabled;
  final String label;
  final VoidCallback onTap;
  const PrimaryButton(
      {super.key,
      required this.isEnabled,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: isEnabled.value ? const Color(0xffc2e969) : Colors.grey,
          ),
          width: double.infinity,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isEnabled.value ? const Color(0xff2F6A49) : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }
}
