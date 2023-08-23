// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/notification/delete_votification_model.dart';
import '../../model/notification/notification_model.dart';
import '../../services/notification_service/delete_notification_service.dart';
import '../../services/notification_service/notification_service.dart';
import '../../theme/constant/constants.dart';

class NotificationController extends GetxController {
  Future<NotificationModel?> notification({
    required BuildContext context,
    required String url,
  }) async {
    final data = await NotificationService()
        .notification( url: url);
    if (data['status'] != null && data['statusCode'] == 200) {
      return NotificationModel.fromJson(data);
    } else {
   ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }
   Future<DeleteNotificationModel?> deleteNotification({
    required BuildContext context,
    required String id,
  }) async {
    final data = await DeleteNotificationService()
        .deleteNotification( id: id);
    if (data['status'] != null && data['statusCode'] == 200) {
      return DeleteNotificationModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }
}
