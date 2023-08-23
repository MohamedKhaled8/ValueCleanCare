// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/secure_storage.dart';
import 'package:vc/services/auth_service/login_service.dart';
import 'package:vc/theme/constant/constants.dart';
import '../../helper/check_internet.dart';
import '../../model/auth/login_model.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordShown = false;
  void showPassword() {
    isPasswordShown = !isPasswordShown;
    update();
  }
var isPasswordHidden = true.obs;
  bool isCheckBox = false;
  var counter = 0.obs;
  LoginModel? loginData;

  void isCheckBoxes() {
    isCheckBox = !isCheckBox;
    update();
  }

  Future<LoginModel?> login({
    required BuildContext context,
    required bool remember,
  }) async {
    final FirebaseMessaging fierbaseMessaging = FirebaseMessaging.instance;
    await Secure_Storage.setData(
        key: 'userDeviceToken',
        value: jsonEncode(await fierbaseMessaging.getToken()));
    final dToken = await fierbaseMessaging.getToken();

    final data = await LoginService().login(
      body: {
        'email': email.text,
        'password': password.text,
        'device_token': dToken,
      },
    );
    if (await checkInternetConnection()) {
      if (data != null && data['success'] != null && data['success']) {
        // ignore: use_build_context_synchronously
        ShowBanner.showBanner(context: context, text: data['message']);
        loginData = LoginModel.fromJson(data);
        await Secure_Storage.deleteData(key: 'userLoginData');

        await Secure_Storage.setData(
            key: 'userLoginData', value: jsonEncode(data));
        await CachingData.cachingLoginData();

        await Secure_Storage.setData(
            key: 'remember', value: remember.toString());
        return loginData;
      } else if (data != null && data['message'] != null) {
        // ignore: use_build_context_synchronously
        ShowBanner.showBanner(context: context, text: data['message']);
      }
      else if ( data['error'] != null) {
        // ignore: use_build_context_synchronously
        ShowBanner.showBanner(context: context, text: data['error']);
      }
       else {
        // ignore: use_build_context_synchronously
        ShowBanner.showBanner(context: context, text: data['message']);
      }
    }
    
     else {
      // ignore: use_build_context_synchronously
      ShowBanner.showBanner(
          context: context, text: 'Check Your Internet Connection!');
    }
    return null;
  }
}
