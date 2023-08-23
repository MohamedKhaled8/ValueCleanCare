import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

import '../../model/auth/faqs_model.dart';

class FaqsController extends GetxController {
  Future<FqaModel?> faqs({required BuildContext context}) async {
    final data =
        await ApiService().get(url: EndPointName.faqs, token: loginData!.token);
    return FqaModel.fromJson(data);
  }
}
