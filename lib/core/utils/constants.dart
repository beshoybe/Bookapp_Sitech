import 'package:booksapp/core/utils/app_colors.dart';
import 'package:flash/flash.dart' as fl;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static Future<bool?> toastShow(
      {required String message, bool failed = true}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: failed ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp);
  }
}
