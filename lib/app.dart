import 'package:booksapp/config/routes/app_routes.dart';
import 'package:booksapp/config/themes/app_theme.dart';
import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'injection_container.dart' as di;

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => di.sl<HomeCubit>()
                  ..getBooks()
                  ..connectionCheckThread()
                  ..getBookmarkedBooks())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: appTheme(),
            routes: routes,
            home: child,
          ),
        );
      },
    );
  }
}
