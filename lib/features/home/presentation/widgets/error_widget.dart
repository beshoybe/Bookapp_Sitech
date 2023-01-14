import 'package:flutter/material.dart';

Widget errorWidget({required Function onPressed}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("An error occured"),
        ElevatedButton(
            onPressed: () {
              onPressed();
            },
            child: Text("Try again"))
      ],
    ),
  );
}
