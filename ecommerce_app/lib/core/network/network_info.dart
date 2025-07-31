import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    final isConnected = await connectionChecker.hasConnection;
    if (!isConnected) {
      throw NetworkException();
    }
    return isConnected;
  }
}
