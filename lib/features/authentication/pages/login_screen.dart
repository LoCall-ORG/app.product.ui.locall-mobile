import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:locall/api/api_service.dart';
import 'package:locall/common/otp_bottom_sheet.dart';
import 'package:locall/features/authentication/pages/registration_screen.dart';
import 'package:locall/utils/localisation/app_locale.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();
  String? _errorMessage;
  final ApiService apiService = Get.find();
  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _checkMobileNumber() async {
    print('hi 1');
    final mobile = _mobileController.text;
    if (_isMobileNumberValid(mobile)) {
      try {
        final Map<String, dynamic> requestBody = {
          "mobile": {
            "countryCode": "+91",
            "number": mobile,
          }
        };

        final response =
            await apiService.postRequest('/check-user', requestBody);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final userFound = responseBody['data']['userFound'];

          if (userFound) {
            print('3');
            _sendOTP(mobile);
          } else {
            print('4');
            Get.to(() => RegistrationScreen(
                  mobileNumber: mobile,
                ));
          }
        }
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  Future<void> _sendOTP(String mobile) async {
    try {
      final Map<String, dynamic> otpRequestBody = {
        "mobile": {
          "countryCode": "+91",
          "number": mobile,
        }
      };

      final otpResponse =
          await apiService.postRequest('/send-otp', otpRequestBody);

      if (otpResponse.statusCode == 200) {
        final otpResponseBody = jsonDecode(otpResponse.body);
        final otpData = otpResponseBody['data'];

        final hash = otpData['hash'];
        final expireAt = otpData['expireAt'];

        _showOTPBottomSheet(mobile, hash, expireAt);
      } else {
        print('Failed to send OTP. Status code: ${otpResponse.statusCode}');
        _showError('Failed to send OTP. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
      _showError('Error occurred while sending OTP. Please try again.');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isMobileNumberValid(String mobile) {
    if (mobile.isEmpty) {
      _errorMessage = 'Please enter your mobile number.';
      return false;
    } else if (mobile.length != 10) {
      _errorMessage = 'Mobile number must be 10 digits long.';
      return false;
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      _errorMessage = 'Mobile number must contain only digits.';
      return false;
    }
    _errorMessage = null;
    return true;
  }

  void _showOTPBottomSheet(String mobile, String hash, int expireAt) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return OTPBottomSheet(
          mobileNumber: mobile,
          hash: hash,
          expireAt: expireAt,
          isRegistration: false,
        );
      },
    ).then((_) {
      setState(() {
        _mobileController.clear();
        _errorMessage = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
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
                const SizedBox(height: 60),
                Text(
                  AppLocale.login.getString(context),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: AppLocale.enterMobileNumber.getString(context),
                    labelStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
                    setState(() {
                      _isMobileNumberValid(value);
                      if (_errorMessage != null && value.isNotEmpty) {
                        _errorMessage = null;
                      }
                    });
                  },
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    print('2');
                    setState(() {
                      _isMobileNumberValid(_mobileController.text);
                    });

                    _checkMobileNumber();
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: const Color(0xffc2e969),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        AppLocale.login.getString(context),
                        style: const TextStyle(
                            color: Color(0xff2F6A49),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
