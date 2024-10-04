import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:locall/features/authentication/pages/login_screen.dart';
import 'package:locall/utils/localisation/app_locale.dart';
import 'package:get/get.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage;

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (language == 'en') {
        setLanguageToEnglish();
      } else {
        setLanguageToHindi();
      }
      Get.to(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          selectLanguage('en');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedLanguage == 'en'
                              ? const Color(0xffc2e969)
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontSize: 20,
                            color: selectedLanguage == 'en'
                                ? const Color(0xff2F6A49)
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          selectLanguage('hi');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedLanguage == 'hi'
                              ? const Color(0xffc2e969)
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'हिंदी',
                          style: TextStyle(
                            fontSize: 20,
                            color: selectedLanguage == 'hi'
                                ? const Color(0xff2F6A49)
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
