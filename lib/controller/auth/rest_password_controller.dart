// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/services/auth_service/rest_password_service.dart';

import '../../theme/constant/constants.dart';

class RestPasswordController extends GetxController {
  Future<dynamic> restPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    final data = await RestPasswordService().restPassword(body: {
      'email': email,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    });
    if (data['statusCode'] != null && data['statusCode'] == 200) {
     ShowBanner.showBanner(context: context, text: data['message']);

      return true;
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
      return false;
    }
  }
}
