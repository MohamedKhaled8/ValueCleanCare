// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/db_sh.dart';
import 'package:vc/model/services_model/subService_model.dart';
import 'package:vc/model/services_model/user_home_model.dart';
import 'package:vc/services/userHomeService/subService_service.dart';
import 'package:vc/services/userHomeService/user_home_service.dart';
import 'package:vc/theme/constant/constants.dart';

class UserHomeController extends GetxController {
  UserHomeModel? allUserHomeData;

  Future<SubServiceModel?> subService(
      {required BuildContext context, required String id}) async {
    final data = await SubService().subService(id: id);
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return SubServiceModel.fromJson(data);
    }
    return null;
  }

  Future<UserHomeModel?> userHome({required BuildContext context}) async {
    final data = await UserHomeService().getUserHome();

    if (data != null) {
      await Shared_Preference.clearData(key: 'userHomeData');
      await Shared_Preference.setData(
          key: 'userHomeData', value: jsonEncode(data));
      allUserHomeData = UserHomeModel.fromJson(data);
      return allUserHomeData;
    } else {
      if (data == null) {
        ShowBanner.showBanner(context: context, text: data['message']);
      }
    }
    return null;
  }
}
