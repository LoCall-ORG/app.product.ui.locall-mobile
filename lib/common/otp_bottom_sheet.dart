import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:locall/api/api_service.dart';
import 'package:locall/features/authentication/pages/login_screen.dart';
import 'package:locall/pages/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class OTPBottomSheet extends StatefulWidget {
  final String mobileNumber;
  final String hash;
  final int expireAt;
  final bool isRegistration;
  final Map<String, dynamic>? registrationData;

  const OTPBottomSheet({
    Key? key,
    required this.mobileNumber,
    required this.hash,
    required this.expireAt,
    required this.isRegistration,
    this.registrationData,
  }) : super(key: key);

  @override
  _OTPBottomSheetState createState() => _OTPBottomSheetState();
}

class _OTPBottomSheetState extends State<OTPBottomSheet> {
  final ValueNotifier<String> otpNotifier = ValueNotifier<String>('');
  Timer? timer;
  int start = 30;
  bool isResendEnabled = false;
  final ApiService apiService = Get.find();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    otpNotifier.dispose();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      isResendEnabled = false;
      start = 30;
    });
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (start == 0) {
            isResendEnabled = true;
            timer.cancel();
          } else {
            start--;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmOTP() async {
    final otp = otpNotifier.value;
    if (otp.isEmpty) {
      _showError("Please enter OTP");
      return;
    }

    if (widget.isRegistration) {
      await _registerUser(widget.registrationData!);
    } else {
      await _loginUser();
    }
  }

  Future<void> _loginUser() async {
    final otp = otpNotifier.value;
    try {
      final Map<String, dynamic> requestBody = {
        "hash": widget.hash,
        "mobile": {
          "countryCode": "+91",
          "number": widget.mobileNumber,
        },
        "expireAt": widget.expireAt,
        "otp": int.parse(otp),
      };

      final response = await apiService.postRequest('/login-user', requestBody);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success']) {
        final token = responseBody['data']['token'];
        Navigator.pop(context);
        print("Login successful, Token: $token");
        Get.to(() => const HomePage());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
      } else {
        _showError(
            responseBody['message'] ?? "Login failed. Please try again.");
      }
    } catch (error) {
      _showError("Error: Failed to verify OTP. Please try again.");
    }
  }

  Future<void> _registerUser(Map<String, dynamic> registrationData) async {
    print('Starting registration process...');

    registrationData["otp"] = otpNotifier.value;

    print('OTP: ${registrationData["otp"]}');
    print('Registration Data: $registrationData');

    try {
      final response =
          await apiService.postRequest('/register-user', registrationData);

      final responseBody = jsonDecode(response.body);
      print('Response Body: $responseBody');

      if (response.statusCode == 201 && responseBody['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
        Get.to(() => LoginScreen());
      } else {
        _showError('Registration failed: ${responseBody['message']}');
      }
    } catch (error) {
      _showError('Error occurred during registration: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "OTP sent to ${widget.mobileNumber}",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 4,
              onChanged: (value) {
                otpNotifier.value = value;
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(15),
                borderWidth: 1,
                activeColor: const Color(0xffc2e969),
                inactiveColor: Colors.grey,
                selectedColor: const Color(0xffc2e969),
                fieldHeight: 50,
                fieldWidth: 40,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmOTP,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color(0xffc2e969),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Color(0xff2F6A49),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: isResendEnabled
                  ? () {
                      startTimer();
                    }
                  : null,
              child: Text(
                isResendEnabled ? "Resend OTP" : "Resend OTP in $start seconds",
                style: TextStyle(
                  color: isResendEnabled ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
