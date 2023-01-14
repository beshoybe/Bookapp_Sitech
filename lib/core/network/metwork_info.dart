import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker conncectionCheker;

  NetworkInfoImpl({required this.conncectionCheker});
  @override
  Future<bool> get isConnected async => await conncectionCheker.hasConnection;
}
