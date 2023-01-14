import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackGround,
    primaryColor: AppColors.primary,
    textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
    appBarTheme: AppBarTheme(
        elevation: 0,
        actionsIconTheme: IconThemeData(color: AppColors.iconColor),
        backgroundColor: AppColors.primary),
  );
}
