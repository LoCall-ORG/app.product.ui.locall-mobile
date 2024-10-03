import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:locall/api/api_service.dart';
import 'package:locall/common/otp_bottom_sheet.dart';
import 'package:locall/utils/localisation/app_locale.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobileNumber;

  const RegistrationScreen({Key? key, required this.mobileNumber})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  String? _selectedGender;
  String? _selectedRole;
  bool _acceptedPolicy = false;
  final ApiService apiService = Get.find();

  final List<String> _genders = ['male', 'female', 'other'];
  final List<String> _roles = ['seller', 'customer'];

  // For OTP
  final _otpController = TextEditingController();
  String? _hash;
  int? _expireAt;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _mobileController.text = widget.mobileNumber;
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _otpController.dispose();
    super.dispose();
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

        setState(() {
          _hash = otpData['hash'];
          _expireAt = otpData['expireAt'];
        });

        _showOTPBottomSheet(mobile, _hash!, _expireAt!);
      } else {
        print('Failed to send OTP. Status code: ${otpResponse.statusCode}');
        _showError('Failed to send OTP. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
      _showError('Error occurred while sending OTP. Please try again.');
    }
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
          isRegistration: true,
          registrationData: {
            "mobile": {
              "number": _mobileController.text,
            },
            "role": _selectedRole,
            "name": _nameController.text,
            "gender": _selectedGender,
            "email": _emailController.text,
            "city": "66fa5d9f417f8cbd4d5c98a7",
            "hash": hash,
            "expireAt": expireAt,
          },
        );
      },
    ).then((_) {
      setState(() {
        _mobileController.clear();
        _errorMessage = null;
      });
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isMobileNumberValid(String mobile) {
    if (mobile.isEmpty) {
      _showError('Please enter your mobile number.');
      return false;
    } else if (mobile.length != 10) {
      _showError('Mobile number must be 10 digits long.');
      return false;
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      _showError('Mobile number must contain only digits.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      AppLocale.registration.getString(context),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: _inputDecoration(
                              AppLocale.enterMobileNumber.getString(context)),
                          validator: (value) {
                            if (!_isMobileNumberValid(value ?? '')) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDecoration(
                              AppLocale.name.getString(context)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocale.nameRequired.getString(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: _inputDecoration(
                              AppLocale.email.getString(context)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocale.emailRequired.getString(context);
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return AppLocale.invalidEmail.getString(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _cityController,
                          decoration: _inputDecoration(
                              AppLocale.city.getString(context)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocale.cityRequired.getString(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: _inputDecoration(
                              AppLocale.gender.getString(context)),
                          items: _genders.map((String gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocale.genderRequired
                                  .getString(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: _inputDecoration(
                              AppLocale.role.getString(context)),
                          items: _roles.map((String role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRole = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocale.roleRequired.getString(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptedPolicy,
                              onChanged: (bool? value) {
                                setState(() {
                                  _acceptedPolicy = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                AppLocale.acceptPrivacyPolicy
                                    .getString(context),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate() &&
                                  _acceptedPolicy) {
                                _sendOTP(_mobileController.text);
                              } else if (!_acceptedPolicy) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(AppLocale
                                          .acceptPolicyRequired
                                          .getString(context))),
                                );
                              }
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xffc2e969),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocale.next.getString(context),
                                  style: const TextStyle(
                                    color: Color(0xff2F6A49),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xffc2e969)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      counterText: '',
    );
  }
}
