import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:locall/features/authentication/controllers/splash_screen_contoller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashScreenContoller>();
    return Scaffold(
      backgroundColor: const Color(0xffc2e969),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: Get.height * 0.3),
                child: const Text(
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
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: SpinKitRing(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
