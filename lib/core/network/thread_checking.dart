import 'package:booksapp/core/utils/constants.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

@pragma('vm:entry-point')
void checkConnectivity(int id) async {
  InternetConnectionChecker networkInfo = InternetConnectionChecker();
  bool restored = true;
  while (true) {
    if (!(await networkInfo.hasConnection) && restored) {
      restored = false;
      Constants.toastShow(message: "No internet connection", failed: true);
    } else if ((await networkInfo.hasConnection) && restored == false) {
      Constants.toastShow(message: "Connection Restored", failed: false);
      restored = true;
    }
    await Future.delayed(Duration(seconds: 1));
  }
}
