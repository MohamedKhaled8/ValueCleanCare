// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vc/services/auth_service/logout_service.dart';
import 'package:vc/theme/constant/constants.dart';

import '../../helper/secure_storage.dart';
import '../../view/auth_view/auth_view.dart';


class LogoutController extends GetxController {
  Future<dynamic> logout({required BuildContext context}) async {
    final data = await LogoutService().logout(
    
    );
    if (data['status'] == 'success' && data['message'] != null) {
       await Secure_Storage.deleteData(key: 'userLoginData');
          Get.offAll(
            () => const AuthAppView(),
            transition: Transition.topLevel,
            duration: const Duration(milliseconds: 2000),
          );
      ShowBanner.showBanner(context: context, text: data['message']);
      return true;
    } else {
      return false;
    }
  }
}
