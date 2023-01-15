import 'package:flutter/material.dart';
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
        fontSize: 12.0);
  }
}
