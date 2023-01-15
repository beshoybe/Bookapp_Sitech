import 'package:booksapp/core/utils/app_colors.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget detailsWidget(
    Book book, Function onPressed, bool isBookmarked, Function delete) {
  return Column(
    children: [
      SizedBox(
        height: 252.h,
      ),
      Expanded(
          child: Container(
        padding: EdgeInsets.only(left: 13.w, top: 28.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  book.author,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.authorDetailsColor),
                ),
              ),
              IconButton(
                iconSize: 30.r,
                onPressed: () {
                  delete();
                },
                color: Colors.red,
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              IconButton(
                iconSize: 30.r,
                onPressed: () {
                  onPressed();
                },
                color: isBookmarked ? Colors.yellow : Colors.grey,
                icon: const Icon(
                  Icons.bookmark_sharp,
                ),
              )
            ],
          ),
          Text(
            book.name,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 19.h,
          ),
          Text(
            book.description,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.DescriptionDetialsColor),
          ),
        ]),
      ))
    ],
  );
}
