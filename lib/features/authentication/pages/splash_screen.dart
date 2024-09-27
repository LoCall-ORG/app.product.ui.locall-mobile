import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locall/features/authentication/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2e969),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              const Text(
                "LoCall",
                style: TextStyle(
                  fontFamily: "Horizon",
                  fontSize: 65,
                  color: Colors.white,
                  letterSpacing: 4,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 300,
              ),
              AnimatedTextKit(
                onFinished: () {
                  Get.to(LoginScreen());
                },
                animatedTexts: [
                  TyperAnimatedText(
                    'Local is calling ...',
                    textStyle: GoogleFonts.openSans(fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
