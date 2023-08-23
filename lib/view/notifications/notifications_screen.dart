import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/controller/notification/notification_controller.dart';
import 'package:vc/model/notification/notification_model.dart';
import 'package:vc/view/notifications/notification_card.dart';
import 'package:vc/widgets/no_data_txt.dart';
import '../../helper/end_points.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/default_appBar.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final NotificationController notificationController =
      NotificationController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DefaultAppBar(
          ontap: () {
            Get.back();
          },
          text: "Notifications".tr,
          size: 120,
          screenUtil: screenUtil),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: notificationController.notification(
                  context: context, url: EndPointName.NOTIFICATIONS),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final NotificationModel notificationModel =
                      snapshot.data as NotificationModel;
                  if (notificationModel.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return NotificationsCard(
                            notificationData: notificationModel.data![index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: screenUtil.setHeight(15),
                          );
                        },
                        itemCount: notificationModel.data!.length,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                      ),
                    );
                  } else {
                    return NoDataTxt(text: 'No Notifications Yet'.tr);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    ));
  }
}
