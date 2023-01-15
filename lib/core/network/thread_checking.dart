import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/core/utils/constants.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

@pragma('vm:entry-point')
void checkConnectivity(int id) async {
  InternetConnectionChecker networkInfo = InternetConnectionChecker();
  bool restored = true;
  while (true) {
    if (!(await networkInfo.hasConnection) && restored) {
      restored = false;
      Constants.toastShow(
          message: AppStrings.noInternetConnection, failed: true);
    } else if ((await networkInfo.hasConnection) && restored == false) {
      Constants.toastShow(
          message: AppStrings.connectionRestored, failed: false);
      restored = true;
    }
    await Future.delayed(Duration(seconds: 1));
  }
}
