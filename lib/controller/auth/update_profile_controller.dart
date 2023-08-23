// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/auth/profile_model.dart';
import 'package:vc/services/auth_service/update_profile_service.dart';

import '../../theme/constant/constants.dart';

class UpdateProfileController extends GetxController {
  Future<ProfileModel?> updateProfile({
    required String name,
    required String email,
    required List<String> address,
    required String phone,
    required String photo,
    required String nin,
    required BuildContext context,
  }) async {
    final data = await UpdateProfileService().updateProfile(body: {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'photo': photo,
      'NiN': nin,
    });
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      ShowBanner.showBanner(
          context: context, text: 'Updated Profile Successfully');

      return ProfileModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }
}
