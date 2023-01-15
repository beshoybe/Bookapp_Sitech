import 'package:flutter/material.dart';

Widget errorWidget({required Function onPressed}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("An error occured"),
        ElevatedButton(
            onPressed: () {
              onPressed();
            },
            child: const Text("Try again"))
      ],
    ),
  );
}
