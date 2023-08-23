import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/change_card_controller.dart';
import 'package:vc/controller/payment_controller.dart';
import 'package:vc/model/payment/all_payment_mdel.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/payment/add_payment_card.dart';
import 'package:vc/widgets/credet_card.dart';

import '../../widgets/cutom_buttom_two.dart';
import '../../widgets/default_appBar.dart';

class PaymentSettingScreen extends StatelessWidget {
  PaymentSettingScreen({Key? key}) : super(key: key);

  final controller = Get.put(ChangeCardController());
  final PaymentController _paymentController = PaymentController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
            ontap: () {
              Get.back();
            },
            text: "Payment Settings".tr,
            screenUtil: screenUtil,
            size: 130),
        backgroundColor: const Color(0xffF0F0F0),
        body: Column(
          children: [
            FutureBuilder(
                future: _paymentController.allPayment(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    final allPaymentData = snapshot.data as AllPaymentModel;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: allPaymentData.data!.length,
                          itemBuilder: (cotext, index) {
                            return Container(
                              width: screenUtil.setWidth(350),
                              height: screenUtil.setHeight(160),
                              margin: const EdgeInsets.all(10).w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(15).w),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CredetCard(
                                      paymentCard: allPaymentData.data![index]),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     // _paymentController.
                                  //   },
                                  //   child: Container(
                                  //     height: screenUtil.setHeight(43),
                                  //     width: screenUtil.setWidth(400),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey.withOpacity(0.8),
                                  //       borderRadius: const BorderRadius.only(
                                  //         bottomRight: Radius.circular(15),
                                  //         bottomLeft: Radius.circular(15),
                                  //       ),
                                  //     ),
                                  //     child: const Center(
                                  //       child: Text(
                                  //         'Delete Card',
                                  //         style: TextStyle(
                                  //             fontSize: 18,
                                  //             color: Colors.black),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenUtil.setHeight(60),
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))
                  .r,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 5,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5).r,
            child: CustomButtonTWo(
                screenUtil: screenUtil,
                color: ColorApp.primary,
                color1: Colors.white,
                txt: 'Add new Card'.tr,
                onTap: () {
                  Get.to(() => AddPaymentCard(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 1000));
                }),
          ),
        ),
      ),
    );
  }
}
