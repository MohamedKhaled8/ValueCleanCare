import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:vc/helper/db_sh.dart';
import 'package:vc/helper/secure_storage.dart';
import 'package:vc/model/auth/login_model.dart';
import 'package:vc/model/services_model/user_home_model.dart';

class CachingData {
  static Future<LoginModel?> cachingLoginData() async {
    try {
      if (await Secure_Storage.getData(key: 'userLoginData') != null) {
        loginData = LoginModel.fromJson(
            jsonDecode(await Secure_Storage.getData(key: 'userLoginData')));
      }
    // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  static Future<UserHomeModel?> cachingUserHomeData() async {
    // ignore: unused_local_variable
    final userHomeData = UserHomeModel.fromJson(
        jsonDecode(await Shared_Preference.getData(key: 'userHomeData')));
    return null;
  }

  static Future<bool> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error('Location permissions are denied');
        return false;
      } else {
        if (await Geolocator.isLocationServiceEnabled()) {
          location = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          await Shared_Preference.setData(
              key: 'userLocation', value: jsonEncode(location));
          return true;
        } else {
          return true;
        }
      }
    } else {
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return true;
    }
  }

  static Position? location;
  static UserHomeModel? userHomeData;
}

 LoginModel? loginData;
String selectedLocation = '';
