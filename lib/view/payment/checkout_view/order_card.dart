import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/requriment_controller.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/model/order_model.dart';
import 'package:vc/model/orders/order_model.dart';
import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import '../../service_form/service_form_screen.dart';
import '../../order_histroy/order_details_screen.dart';

import '../../../model/services_model/user_home_model.dart' as home;

class PaymentOrderCard extends StatelessWidget {
  final OrderCardModel orderModel;
  final home.Service? serviceModel;
  const PaymentOrderCard(
      {super.key, required this.orderModel, this.serviceModel});

  @override
  Widget build(BuildContext context) {
    final RequrimentController requrimentController =
        Get.put(RequrimentController());
    final UserHomeController extraServiceController =
        Get.put(UserHomeController());
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10).r,
      padding: const EdgeInsets.only(top: 15).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(15).w),
        boxShadow: const [
          BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10).r,
                child: Text(
                  "Order# ${checkOrderNumberlength(orderModel.id)}",
                  style: TextStyle(fontSize: 18.sp, color: ColorApp.primary),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenUtil.setHeight(13),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 13, right: 20).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Date : ".tr,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                    Text(
                      orderModel.date,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Time :".tr,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                    Text(
                      orderModel.time,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(8),
          ),
          ListTile(
            title: Text(
              "Address".tr,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            subtitle: Text(
              orderModel.address,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    () =>
                        /////////
                        // OrderDetailsScreen(
                        //     orderInfo: OrdersModel().data![0].id),
                        OrderDetailsScreen(
                            orderInfo: Data(
                                id: 1,
                                address: 'mans',
                                date: '19/6',
                                day: 6,
                                paymentStatus: 'done',
                                repeat: 'true',
                                service: [],
                                status: 'true',
                                time: '4:20',
                                workArea: 'Nabarouh')),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 1000),
                  );
                },
                child: IntrinsicWidth(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 45, vertical: 13)
                            .r,
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15))
                          .r,
                    ),
                    child: Center(
                      child: Text(
                        'See All Details'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final requrimentData = await requrimentController.requirement(
                      context: context, id: serviceModel!.id.toString());
                  final subServicesData =
                      // ignore: use_build_context_synchronously
                      await extraServiceController.subService(
                          context: context, id: serviceModel!.id.toString());
                  Get.to(
                    () => ServiceFormScreen(
                      serviceModel: serviceModel,
                      requirmentModel: requrimentData!,
                      subServiceModel: subServicesData!,
                    ),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 1000),
                  );
                },
                child: IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.only(
                            top: 13, bottom: 13, right: 75, left: 70.5)
                        .r,
                    // padding: const EdgeInsets.symmetric(
                    //         horizontal: 60.5, vertical: 13)
                    //     .r,
                    // width: screenUtil.screenWidth / 2 - 20,
                    decoration: BoxDecoration(
                      color: orderModel.orderState == "NotFinished"
                          ? Colors.blueAccent.withOpacity(0.2)
                          : const Color(0xff017BAB),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ).r,
                    ),
                    child: Center(
                      child: Text(
                        'Edit'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String checkOrderNumberlength(text) {
  if (text.toString().length > 8) {
    return "${text.toString().substring(0, 7)}...";
  } else {
    return text.toString();
  }
}

Color? returnColor(String state) {
  if (state == "inPrograss") {
    return Colors.grey;
  } else if (state == "NotFinished") {
    return Colors.grey.withOpacity(0.1);
  }
  return null;
}
