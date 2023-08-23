import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';
import 'package:vc/model/auth/terms_conditions_model.dart';

class TermsConditionsController extends GetxController {
  Future<TermsAndConditionsModel?> termsConditions(
      {required BuildContext context}) async {
    final data = await ApiService()
        .get(url: EndPointName.termsAndConditions, token: loginData!.token);
    return TermsAndConditionsModel.fromJson(data);
    
  }
}
