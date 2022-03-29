import 'dart:io';

import 'package:flutter_toastr/flutter_toastr.dart';

bool kIsDesktop = Platform.isLinux || Platform.isMacOS || Platform.isWindows;

class CustomToast {
  void showToast(context, {required String msg}) {
    FlutterToastr.show(
      msg,
      context,
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.bottom,
    );
  }
}
