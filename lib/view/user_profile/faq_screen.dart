import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/faqs_controller/faqs_controller.dart';
import 'package:vc/model/auth/faqs_model.dart';
import 'package:vc/theme/constant/const_colors.dart';

import '../../theme/constant/sized.dart';
import '../../widgets/default_appBar.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});
  final FaqsController faqsController = Get.put(FaqsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          ontap: () {
            Get.back();
          },
          text: "FAQ’s".tr,
          screenUtil: screenUtil,
          size: 130,
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: faqsController.faqs(context: context),
              builder: ((context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final FqaModel fqaModel = snapshot.data as FqaModel;
                  return Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Text(
                                    '${fqaModel.fqa[index].title} ?',
                                    style: TextStyle(
                                        color: ColorApp.primary,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: screenUtil.setWidth(15)),
                                  Expanded(
                                    child: Text(
                                      fqaModel.fqa[index].content,
                                      style: TextStyle(
                                          color: ColorApp.grey,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: fqaModel.fqa.length));
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
