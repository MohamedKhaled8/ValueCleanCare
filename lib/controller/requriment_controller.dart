import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/requirement_model.dart';
import 'package:vc/services/requirement_service.dart';

class RequrimentController extends GetxController {
  Future<RequriementModel?> requirement(
      {required BuildContext context, required String id}) async {
    final data =
        await RequriementService().requiremnt(id: id);
    if (data != null && data['statusCode'] == 200) {
      return RequriementModel.fromJson(data);
    }
    return null;
  }
}
