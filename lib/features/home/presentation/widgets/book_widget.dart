import 'dart:io';

import 'package:booksapp/config/routes/app_routes.dart';
import 'package:booksapp/features/home/presentation/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/book.dart';

Widget bookWidget(context,
    {required Book book,
    required Color color,
    bool clickable = true,
    CancelToken? cancleToken}) {
  return Container(
    padding: EdgeInsets.only(left: 10.w, top: 16.h, bottom: 16.h, right: 10.w),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: color),
    width: ScreenUtil.defaultSize.width.w,
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
    alignment: Alignment.center,
    height: 125.h,
    child: InkWell(
      onTap: !clickable
          ? null
          : () {
              Navigator.pushNamed(context, Routes.detailsRoute).then((value) {
                cancleToken!.cancel();
              });
              HomeCubit.get(context).getBookById(book.id, cancleToken!);
              HomeCubit.get(context).getBookmarkedBooks();
            },
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 91.w,
          height: 94.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (book.cover.contains("http")
                      ? NetworkImage(book.cover)
                      : FileImage(File(book.cover)) as ImageProvider)),
              borderRadius: BorderRadius.circular(20.r)),
        ),
        SizedBox(
          width: 6.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              authorContainer(author: book.author),
              Text(
                book.name,
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 6.h,
              ),
              Expanded(
                child: Text(
                  book.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20.r,
        )
      ]),
    ),
  );
}

Widget authorContainer({required String author}) {
  return Container(
    padding: EdgeInsets.all(3.r),
    margin: EdgeInsets.only(bottom: 11.h),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(40.r)),
    width: 78.w,
    child: Text(
      author,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.w700),
    ),
  );
}
