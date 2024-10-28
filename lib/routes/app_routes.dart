import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:locall/config/app_service.dart';
import 'package:locall/features/authentication/bindings/login_screen_binding.dart';
import 'package:locall/features/authentication/bindings/register_screen_binding.dart';
import 'package:locall/features/authentication/bindings/splash_screen_binding.dart';
import 'package:locall/features/authentication/screens/login_screen.dart';
import 'package:locall/features/authentication/screens/registration_screen.dart';
import 'package:locall/features/authentication/screens/select_language.dart';
import 'package:locall/features/authentication/screens/splash_screen.dart';
import 'package:locall/features/authentication/screens/shop_registration_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String languageScreen = '/language_screen';
  static const String loginScreen = '/login_screen';
  static const String registerUserScreen = '/register_user';
  static const String registerShopScreen = '/register_shop';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: languageScreen,
      page: () => const LanguageSelectionScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: registerUserScreen,
      page: () => RegistrationScreen(
        appService: AppService(),
      ),
      binding: RegisterScreenBinding(),
    ),
    GetPage(
      name: registerShopScreen,
      page: () => const ShopRegistrationScreen(),
      // binding: RegisterScreenBinding(),
    ),
  ];
}
