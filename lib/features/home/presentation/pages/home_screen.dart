import 'package:booksapp/core/utils/app_colors.dart';
import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/features/home/presentation/cubit/home_cubit.dart';
import 'package:booksapp/features/home/presentation/widgets/app_bar.dart';
import 'package:booksapp/features/home/presentation/widgets/book_widget.dart';
import 'package:booksapp/features/home/presentation/widgets/circular_progress.dart';
import 'package:booksapp/features/home/presentation/widgets/error_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        floatingActionButton: cubit.showFloatingAction
            ? FloatingActionButton(
                onPressed: () {
                  cubit.goToUp();
                },
                child: Icon(
                  Icons.arrow_upward_outlined,
                  size: 20.r,
                ),
              )
            : null,
        appBar: homeAppBar(context),
        body: cubit.errorOcurred
            ? errorWidget(onPressed: cubit.getBooks)
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Text(
                    AppStrings.appTitle,
                    style:
                        TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await cubit.reloadBooks();
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent) {
                          cubit.loadMore();
                        } else if ((notification.metrics.pixels !=
                                notification.metrics.minScrollExtent) &&
                            !cubit.showFloatingAction) {
                          cubit.showFloating();
                        } else if ((notification.metrics.pixels <=
                                notification.metrics.minScrollExtent) &&
                            cubit.showFloatingAction) {
                          cubit.hideFloating();
                        }
                        return false;
                      },
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: cubit.listViewController,
                          shrinkWrap: true,
                          itemCount: cubit.allBooks.length + 1,
                          itemBuilder: (context, index) {
                            CancelToken cancelToken = CancelToken();
                            return (index == cubit.allBooks.length)
                                ? circularProgress(cubit.isLoading)
                                : bookWidget(context,
                                    book: cubit.allBooks[index],
                                    cancleToken: cancelToken,
                                    color: AppColors.getContainerColor(index));
                          }),
                    ),
                  ),
                ),
              ]),
      );
    });
  }
}
