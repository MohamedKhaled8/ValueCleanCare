import 'package:internet_connection_checker/internet_connection_checker.dart';

late bool internet;
Future<bool> checkInternetConnection() async {
  internet = await InternetConnectionChecker().hasConnection;
  return internet;
}
