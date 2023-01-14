import 'package:booksapp/features/home/presentation/pages/bookmarks_page.dart';
import 'package:booksapp/features/home/presentation/pages/details_screen.dart';
import 'package:booksapp/features/home/presentation/pages/home_screen.dart';

class Routes {
  static String initialRoute = '/';
  static String detailsRoute = '/details';
  static String bookmarks = '/bookmarks';
}

final routes = {
  Routes.initialRoute: (context) => HomeScreen(),
  Routes.detailsRoute: (context) => const BookDetails(),
  Routes.bookmarks: (context) => BookmarkedBooks(),
};
