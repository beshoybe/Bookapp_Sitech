import 'package:booksapp/core/utils/app_colors.dart';
import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/features/home/presentation/cubit/home_cubit.dart';
import 'package:booksapp/features/home/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarkedBooks extends StatelessWidget {
  const BookmarkedBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.bookmarksTable,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: cubit.bookmarkedBooks.isEmpty
            ? Center(
                child: Text(AppStrings.noBookmarks),
              )
            : cubit.gettingBookMark
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      cubit.getBookmarkedBooks();
                    },
                    child: Container(
                        height: double.infinity.h,
                        width: double.infinity.w,
                        padding: EdgeInsets.only(top: 10.h),
                        child: ListView.builder(
                            itemCount: cubit.bookmarkedBooks.length,
                            itemBuilder: (context, index) {
                              return bookWidget(context,
                                  book: cubit.bookmarkedBooks[index],
                                  color: AppColors.getContainerColor(index),
                                  clickable: false);
                            })),
                  ),
      );
    });
  }
}
