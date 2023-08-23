// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/services/auth_service/forget_password_service.dart';

import '../../theme/constant/constants.dart';

class ForgetPasswordController extends GetxController {
  Future<bool> forgetPassword(
      {required String email, required BuildContext context}) async {
    final data = await ForgetPasswordService().forgetPassword(
      body: {
        'email': email,
      },
    );
    if (data['message'] == 'check your inbox') {
      return true;
    } else {
      return ShowBanner.showBanner(context: context, text: data['message']);
    }
  }
}
