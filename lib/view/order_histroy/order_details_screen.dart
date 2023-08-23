import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
import 'package:vc/view/payment/bottom_bar.dart';
import 'package:vc/widgets/container_shadow.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/default_appBar.dart';

class OrderDetailsScreen extends StatelessWidget {
  final dynamic orderInfo;
  OrderDetailsScreen({Key? key, required this.orderInfo}) : super(key: key);

  final OrderController controller = OrderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        size: 130,
        screenUtil: screenUtil,
        text: 'Order Details'.tr,
        ontap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15).r,
        child: Column(
          children: [
            Container(
              width: screenUtil.screenWidth - 10,
              decoration: buildShadowContainer(
                  borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      .w),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order code'.tr,
                          style: TextStyle(
                              color: ColorApp.primary,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 22.sp),
                          textAlign: TextAlign.center),
                      Text('Order# ${orderInfo.id!}',
                          style: TextStyle(
                              color: ColorApp.primary,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 22.0.sp),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  // buildRowItem(
                  //     'Service name'.tr,
                  //     checkNameLength(
                  //         serviceName: orderInfo.service![0].title!)),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  buildRowItem('Date :'.tr,
                      checkNameLength(serviceName: orderInfo.date!)),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  buildRowItem('Time :'.tr,
                      checkNameLength(serviceName: orderInfo.time!)),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  buildRowItem('Address'.tr,
                      checkNameLength(serviceName: orderInfo.address!)),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  buildRowItem('Repeat'.tr, orderInfo.repeat!),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  // buildRowItem(
                  //     'Extra Service'.tr,
                  //     checkNameLength(
                  //             serviceName: getServiceList(
                  //                 serviceLsit: orderInfo.subService))
                  //         .tr),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  // buildRowItem(
                  //     'Requirement'.tr,
                  //     checkNameLength(
                  //             serviceName: getServiceList(
                  //                 serviceLsit: orderInfo.requirement))
                  //         .tr),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  // buildRowItem(
                  //     'Workers'.tr, '${orderInfo.workers.length} Workers'),
                  // SizedBox(
                  //   height: screenUtil.setHeight(10),
                  // ),
                ],
              ),
            ),
            Container(
              height: screenUtil.setHeight(52),
              width: screenUtil.screenWidth - 10,
              decoration: BoxDecoration(
                  color: ColorApp.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ).r),
              child: Padding(
                padding: const EdgeInsets.all(10.0).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 22.0.sp),
                        textAlign: TextAlign.center),
                    Text('${orderInfo.totalPrice}\$',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0.sp),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: OrderDetailesBottomNavigationBar(
        screenUtil: screenUtil,
        orderId: orderInfo.id.toString(),
        txt: 'Download as pdf'.tr,
      ),
    );
  }

  String getServiceList({required List serviceLsit}) {
    String service = '';

    for (var element in serviceLsit) {
      service += '${element.title}, ';
    }

    return service;
  }

  String checkNameLength({required String serviceName}) {
    if (serviceName.length > 27) {
      return '${serviceName.substring(0, 27)}...';
    } else {
      return serviceName;
    }
  }

  Widget buildRowItem(
    String txt1,
    String txt2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          txt1,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
        const Spacer(),
        Text(
          txt2,
          maxLines: 1,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      ],
    );
  }
}
