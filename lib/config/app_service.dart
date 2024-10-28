import 'dart:io';

import 'package:flutter/foundation.dart';

class AppService {
  bool isAndroid() => !kIsWeb && Platform.isAndroid;
  bool isIos() => !kIsWeb && Platform.isIOS;
}
