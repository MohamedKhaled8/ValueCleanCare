import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/jobs_done_model.dart';
import 'package:vc/services/jobs_done_service.dart';

class JobsDoneController extends GetxController {
  Future<JobsDoneModel?> jobsDone({
    required BuildContext context,
    required String id,
  }) async {
    final data =
        await JobsDoneService().jobsDone(id: id);
    if (data != null && data['statusCode'] == 200) {
      return JobsDoneModel.fromJson(data);
    }
    return null;
  }
}
