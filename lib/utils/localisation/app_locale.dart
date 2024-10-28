import 'package:flutter_localization/flutter_localization.dart';

mixin AppLocale {
  static String letsConnectWithUs = 'lets_connect_with_us';
  static String enterMobileNumber = 'enter_mobile_number';
  static String login = 'login';
  static String continueText = 'continue';
  static String confirm = 'confirm';
  static String registration = 'registration';
  static String name = 'name';
  static String email = 'email';
  static String city = 'city';
  static String gender = 'gender';
  static String role = 'role';
  static String acceptPrivacyPolicy = 'accept_privacy_policy';
  static String next = 'next';
  static String nameRequired = 'name_required';
  static String emailRequired = 'email_required';
  static String invalidEmail = 'invalid_email';
  static String cityRequired = 'city_required';
  static String genderRequired = 'gender_required';
  static String roleRequired = 'role_required';
  static String acceptPolicyRequired = 'accept_policy_required';

  static Map<String, dynamic> EN = {
    letsConnectWithUs: "Let's connect with us!",
    login: "Login",
    enterMobileNumber: "Enter mobile number",
    continueText: "Continue",
    confirm: "Confirm",
    registration: "Registration",
    name: "Name",
    email: "Email",
    city: "City",
    gender: "Gender",
    role: "Role",
    acceptPrivacyPolicy: "I accept the privacy policy",
    next: "Next",
    nameRequired: "Name is required",
    emailRequired: "Email is required",
    invalidEmail: "Please enter a valid email",
    cityRequired: "City is required",
    genderRequired: "Gender is required",
    roleRequired: "Role is required",
    acceptPolicyRequired: "Please accept the privacy policy",
  };

  static Map<String, dynamic> HI = {
    letsConnectWithUs: "हमसे जुड़ें!",
    login: "लॉगिन करें",
    enterMobileNumber: "मोबाइल नंबर दर्ज करें",
    continueText: "जारी रखें",
    confirm: "पुष्टि करें",
    registration: "पंजीकरण",
    name: "नाम",
    email: "ईमेल",
    city: "शहर",
    gender: "लिंग",
    role: "भूमिका",
    acceptPrivacyPolicy: "मैं गोपनीयता नीति को स्वीकार करता हूं",
    next: "अगला",
    nameRequired: "नाम आवश्यक है",
    emailRequired: "ईमेल आवश्यक है",
    invalidEmail: "कृपया एक वैध ईमेल दर्ज करें",
    cityRequired: "शहर आवश्यक है",
    genderRequired: "लिंग आवश्यक है",
    roleRequired: "भूमिका आवश्यक है",
    acceptPolicyRequired: "कृपया गोपनीयता नीति स्वीकार करें",
  };
}

final FlutterLocalization localization = FlutterLocalization.instance;

List<MapLocale> localeList = [
  MapLocale('en', AppLocale.EN),
  MapLocale('hi', AppLocale.HI),
];

void setLanguageToEnglish() => localization.translate('en');
void setLanguageToHindi() => localization.translate('hi');
