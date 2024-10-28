import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showError(String message) => toastification.show(
      type: ToastificationType.error,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 5),
      style: ToastificationStyle.flatColored,
      showProgressBar: false,
    );
