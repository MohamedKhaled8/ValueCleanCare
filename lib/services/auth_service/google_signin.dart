// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';
import 'package:vc/helper/secure_storage.dart';
import 'package:vc/model/auth/login_model.dart';

import '../../theme/constant/constants.dart';


class Google_Signin {
  Future<LoginModel?> googleSignIn(
      {required BuildContext context, required String accessToken}) async {
    LoginModel? googleLoginData;

    final data = await ApiService().post(
      url: EndPointName.GOOGLESIGNIN,
      body: {'access_token': accessToken},
    );

    if (data['statusCode'] == 200) {
      googleLoginData = LoginModel.fromJson(data);

      await Secure_Storage.deleteData(key: 'userLoginData');

      await Secure_Storage.setData(
          key: 'userLoginData', value: jsonEncode(data));

    ShowBanner.showBanner(context: context, text: data['message']);

      await CachingData.cachingLoginData();

      return googleLoginData;
    } else {
      if (data['message'] != null) {
     ShowBanner.showBanner(context: context, text: data['message']);
      }
    }
    return null;
  }
}
