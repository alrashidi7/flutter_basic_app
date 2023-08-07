import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

extension SnackBarEextension on BuildContext {
  dynamic closeSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  dynamic errorSnackBar(String error, int duration) {
    ToastContext().init(this);

    if (!ScaffoldMessenger.of(this).mounted) {
      getSnackBar(error, true, duration);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getSnackBar(error, true, duration);
      });
    }
  }

  dynamic successSnackBar(String msg) {
    ToastContext().init(this);
    if (!ScaffoldMessenger.of(this).mounted) {
      getSnackBar(msg, false, 2);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getSnackBar(msg, false, 2);
      });
    }
  }

  void getSnackBar(String snackText, bool error, int duration) => Toast.show(
        snackText,
        duration: duration,
        gravity: error ? Toast.bottom : Toast.top,
        backgroundRadius: 5,
        backgroundColor:
            error ? const Color(0xFFF44336) : const Color(0xFF81C784),
      );
}
