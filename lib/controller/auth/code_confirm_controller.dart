// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/services/auth_service/check_verify_code_service.dart';

import '../../theme/constant/constants.dart';

class CodeConfirmController extends GetxController {
  Future<dynamic> checkCode({
    required BuildContext context,
    required String email,
    required String code,
  }) async {
    final data = await CodeConfirmService().codeConfirm(
      body: {
        'email': email,
        'code': code,
      },
    );
    if (data['status']) {
      // ignore: use_build_context_synchronously
      ShowBanner.showBanner(context: context, text: data['message']);
      return true;
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
      return false;
    }
  }
}
