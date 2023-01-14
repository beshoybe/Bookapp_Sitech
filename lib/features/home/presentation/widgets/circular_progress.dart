import 'package:flutter/material.dart';

Widget circularProgress(bool isLoading) {
  return Container(
    alignment: Alignment.center,
    child: isLoading ? CircularProgressIndicator() : null,
  );
}
