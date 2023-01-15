import 'package:booksapp/features/home/presentation/cubit/home_cubit.dart';
import 'package:booksapp/features/home/presentation/widgets/app_bar.dart';
import 'package:booksapp/features/home/presentation/widgets/details_widget.dart';
import 'package:booksapp/features/home/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      var cubit = HomeCubit.get(context);

      return Scaffold(
        body: SafeArea(
            child: SizedBox(
                width: double.infinity.w,
                height: double.infinity.h,
                child: cubit.isLoadingBook
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : cubit.currentBook == null
                        ? Center(
                            child: errorWidget(onPressed: () {
                              Navigator.pop(context);
                            }),
                          )
                        : Stack(
                            children: [
                              Container(
                                width: double.infinity.w,
                                height: 305.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(cubit.currentBook!.cover),
                                  ),
                                ),
                              ),
                              detailsBookAppBar(context),
                              detailsWidget(
                                  cubit.currentBook!,
                                  () {
                                    cubit.isBookmarked
                                        ? cubit.removeBookmark(
                                            cubit.currentBook!.id)
                                        : cubit
                                            .bookmarkBook(cubit.currentBook!);
                                  },
                                  cubit.isBookmarked,
                                  () {
                                    cubit.deleteBookById(
                                        cubit.currentBook!.id, context);
                                  })
                            ],
                          ))),
      );
    });
  }
}
