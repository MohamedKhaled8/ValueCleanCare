// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/services/auth_service/delete_account_service.dart';
import 'package:vc/theme/constant/constants.dart';

import '../../helper/secure_storage.dart';
import '../../view/auth_view/auth_view.dart';

class DeleteAccountController extends GetxController {
  Future<dynamic> deleteAccount({required BuildContext context}) async {
    final data = await DeleteAccountService().deleteAccount();
    if (data['status'] == 200 && data['message'] != null) {
      await Secure_Storage.clearData();
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
