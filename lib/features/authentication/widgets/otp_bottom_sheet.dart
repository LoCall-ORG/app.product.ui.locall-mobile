import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locall/common/widgets/primary_button.dart';
import 'package:locall/config/app_service.dart';

class OtpBottomSheet extends StatefulWidget {
  final AppService appService;
  final Function(String otp) onConfirm;
  final VoidCallback onRetry;
  const OtpBottomSheet({
    super.key,
    required this.onConfirm,
    required this.onRetry,
    required this.appService,
  });

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resendOTP() {
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "OTP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter the 4-digit OTP sent to your number",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff959595),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 17),
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
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (_start == 0) {
                  resendOTP();
                  widget.onRetry();
                }
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _start > 0 ? "Resend OTP in $_start seconds" : "Resend OTP",
                  style: TextStyle(
                    color: const Color(0xff959595),
                    fontWeight: FontWeight.w500,
                    decoration: _start == 0 ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
                isEnabled: true.obs,
                label: "Submit",
                onTap: () {
                  widget.onConfirm("");
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
