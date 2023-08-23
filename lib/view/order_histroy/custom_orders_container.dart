// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
import 'package:vc/controller/requriment_controller.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/services_model/user_home_model.dart';
import 'package:vc/view/order_histroy/qr_scanner.dart';
import 'package:vc/view/rating/rate_experience.dart';
import 'package:vc/view/rating/rate_workers_one.dart';
import 'package:vc/view/service_form/service_form_screen.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import 'order_details_screen.dart';

class CustomOrdersContainer extends StatelessWidget {
  final dynamic data;
  final OrderController _orderController = Get.put(OrderController());
  final UserHomeController homeUserController = Get.put(UserHomeController());

  final RequrimentController requrimentController =
      Get.put(RequrimentController());

  CustomOrdersContainer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10).r,
      padding: const EdgeInsets.only(
        top: 15,
      ).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))
            .r,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order# ${data.id!}",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: ColorApp.primary,
                  ),
                ),
                data.status == "finished"
                    ? InkWell(
                        onTap: () {},
                        child: Text(
                          "Details".tr,
                          style: TextStyle(
                              color: const Color(0xff017BAB), fontSize: 20.sp),
                        ))
                    : InkWell(
                        onTap: () {
                          if (data.status != 'canceled') {
                            _orderController.cancellOrder(
                                context: context, id: data.id!);
                          }
                        },
                        child: Container(
                          height: screenUtil.setHeight(30),
                          width: screenUtil.setWidth(70),
                          decoration: BoxDecoration(
                              color: returnColor(data.status!, true),
                              borderRadius: BorderRadius.circular(15).w),
                          child: Center(
                            child: Text(
                              "Cancel".tr,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(10),
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
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                    Text(
                      data.date!,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Time :".tr,
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                    Text(
                      data.time!,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(10),
          ),
          ListTile(
            title: Text(
              "Address".tr,
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
            subtitle: Text(
              data.address!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  data.status == "finished"
                      ? data.service![0].workers!.length > 0
                          ? Get.to(
                              () => RateWorker(
                                    orderInfo: data,
                                  ),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 1000))
                          : Get.to(
                              () => RateExperience(
                                    orderInfo: data,
                                  ),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 1000))
                      : Get.to(
                          () => OrderDetailsScreen(
                                orderInfo: data,
                              ),
                          transition: Transition.zoom,
                          duration: const Duration(milliseconds: 1000));
                },
                child: Container(
                  height: screenUtil.setHeight(45),
                  width: screenUtil.setWidth(185),
                  decoration: BoxDecoration(
                    color: ColorApp.primary,
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(15))
                            .r,
                  ),
                  child: Center(
                    child: Text(
                      data.status == "finished"
                          ? 'Rate Experience'.tr
                          : 'See All Details'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final getServiceData =
                      await CachingData.cachingUserHomeData();
                  Service? serverData;
                  for (var element in getServiceData!.service!) {
                    if (element.id == data.orderService[0].id) {
                      serverData = element;
                    }
                  }

                  final subServcie = await homeUserController.subService(
                      context: context, id: serverData!.id.toString());

                  final requirements = await requrimentController.requirement(
                      context: context, id: serverData.id.toString());
                  if (subServcie != null && requirements != null) {
                    data.status! == "finished"
                        ? Get.to(() => const QrScan())
                        : Get.to(() => ServiceFormScreen(
                            editOrder: true,
                            orderEditData: {
                              'workArea': data.workArea ?? '5',
                              'date': data.date,
                              'time': data.time,
                              'address': data.address,
                              'repeat': data.repeat,
                              'Extra': data.subService ?? [],
                              // 'Other': data.reapet,
                            },
                            serviceModel: serverData,
                            subServiceModel: subServcie,
                            requirmentModel: requirements));
                  }
                },
                child: Container(
                  height: screenUtil.setHeight(45),
                  width: screenUtil.setWidth(185),
                  decoration: BoxDecoration(
                    color: data.status == "canceled"
                        ? Colors.blueAccent.withOpacity(0.2)
                        : const Color(0xff017BAB),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                    ).r,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        data.status == 'finished'
                            ? Image.asset("assets/icons/mode-portrait.png")
                            : const SizedBox(),
                        Center(
                          child: Text(
                            data.status == "finished"
                                ? 'Team Check'.tr
                                : 'ReSchedule'.tr,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ],
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

  String checkOrderNumberlength(int text) {
    if (text.toString().length > 8) {
      return "${text.toString().substring(0, 7)}...";
    } else {
      return text.toString();
    }
  }
}

Color? returnColor(String state, bool btnState) {
  if (state == "processing") {
    return Colors.grey;
  } else if (state == "canceled") {
    return Colors.grey.withOpacity(0.1);
  }
  return null;
}
