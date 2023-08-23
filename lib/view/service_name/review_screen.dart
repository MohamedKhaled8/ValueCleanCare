import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/theme/constant/sized.dart';
import '../../controller/myController.dart';
import '../../widgets/default_appBar.dart';
import 'card_detailes_view.dart';
import 'package:vc/model/services_model/user_home_model.dart';

class ReviewScreen extends StatelessWidget {
  final controller = Get.put(MyController());
  final List<Review> reviewInfo;
  ReviewScreen({Key? key, required this.reviewInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          size: 120,
          text: 'Reviews'.tr,
          ontap: () {
            Get.back();
          },
          screenUtil: screenUtil,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: reviewInfo.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ReviewCardDetails(
                      reviewInfo: reviewInfo[index],
                      screenUtil: screenUtil,
                      controller: controller,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
