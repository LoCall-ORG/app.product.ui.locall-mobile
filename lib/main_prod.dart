import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:locall/common/bindings/initial_binding.dart';
import 'package:locall/common/helper_functions/loader.dart';
import 'package:locall/config/app_config.dart';
import 'package:locall/config/prod_config.dart';
import 'package:locall/routes/app_routes.dart';
import 'package:locall/utils/localisation/app_locale.dart';
import 'package:locall/utils/shared_prefs.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  Get.put<AppConfig>(ProdConfig());
  runApp(const LoCallApp());
  configLoadingWidget();
}

class LoCallApp extends StatefulWidget {
  const LoCallApp({super.key});

  @override
  State<LoCallApp> createState() => _LoCallAppState();
}

class _LoCallAppState extends State<LoCallApp> {
  @override
  void initState() {
    localization.init(
      mapLocales: [
        MapLocale('en', AppLocale.EN),
        MapLocale('hi', AppLocale.HI),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        theme: ThemeData(
          useMaterial3: true,
        ),
        getPages: AppRoutes.routes,
        initialRoute: AppRoutes.splashScreen,
        initialBinding: InitialBinding(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
