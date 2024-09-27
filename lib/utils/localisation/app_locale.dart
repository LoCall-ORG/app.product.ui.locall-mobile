import 'package:flutter_localization/flutter_localization.dart';

mixin AppLocale {
  static String letsConnectWithUs = 'lets_connect_with_us';
  static String enterMobileNumber = 'enter_mobile_number';
  static String login = 'login';

  static Map<String, dynamic> EN = {
    letsConnectWithUs: "Let's connect with us!",
    login: "Login",
    enterMobileNumber: "Enter mobile number"
  };
  static Map<String, dynamic> HI = {
    letsConnectWithUs: "हमसे जुड़ें!",
    login: "लॉगिन करें",
    enterMobileNumber: "मोबाइल नंबर दर्ज करें"
  };
}

final FlutterLocalization localization = FlutterLocalization.instance;

void setLanguageToEnglish() => localization.translate('en');
void setLanguageToHindi() => localization.translate('hi');
