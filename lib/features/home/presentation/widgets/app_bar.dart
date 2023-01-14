import 'package:booksapp/config/routes/app_routes.dart';
import 'package:booksapp/core/utils/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booksapp/injection_container.dart' as di;
import 'package:dio/dio.dart';

PreferredSizeWidget homeAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {},
        color: Colors.black,
        icon: ImageIcon(
          AssetImage(IconsManager.sort),
          size: 30.r,
        )),
    actions: [
      IconButton(
          onPressed: () {},
          color: Colors.black,
          icon: ImageIcon(
            AssetImage(IconsManager.search),
            size: 30.r,
          )),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.bookmarks);
          },
          color: Colors.black,
          icon: ImageIcon(
            AssetImage(IconsManager.bookmark),
            size: 30.r,
          )),
    ],
  );
}

PreferredSizeWidget detailsBookAppBar(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.black,
        icon: Icon(Icons.arrow_back)),
  );
}
