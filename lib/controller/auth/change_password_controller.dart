// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/services/auth_service/change_passsword_service.dart';
import 'package:vc/theme/constant/constants.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController number = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController addressCont = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassCont = TextEditingController();
  final TextEditingController confirmPassCont = TextEditingController();
  Future<dynamic> changePassword({
    required BuildContext context,
  }) async {
    final data = await ChangePasswordService().changePassword(
      body: {
        'current_password': oldPassword.text,
        'new_password': newPassCont.text,
        'new_password_confirmation': confirmPassCont.text,
        'email': email.text,
      },
  
    );
    if (data['statusCode'] == 200) {
      ShowBanner.showBanner(context: context, text: data['message']);
      return true;
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
      return false;
    }
  }
}
