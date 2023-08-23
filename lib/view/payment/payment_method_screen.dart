// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
import 'package:vc/controller/payment_controller.dart';
import 'package:vc/model/orders/add_order_model.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/view/payment/checkout_view/checkout_screen.dart';
import 'package:vc/widgets/container_shadow.dart';
import 'package:vc/widgets/custom_text_next_button.dart';
import 'package:vc/widgets/popup.dart';

import '../../model/services_model/user_home_model.dart' as home;
import '../../theme/constant/sized.dart';
import '../../widgets/default_appBar.dart';

class PaymentMethodScreen extends StatelessWidget {
  final home.Service serviceInfo;
  final Map orderData;
  PaymentMethodScreen(
      {Key? key, required this.serviceInfo, required this.orderData})
      : super(key: key);

  final PaymentController _controller = Get.put(PaymentController());

  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: DefaultAppBar(
            size: 120,
            ontap: () {
              Get.back();
            },
            screenUtil: screenUtil,
            text: 'payment methods'.tr,
          ),
          body: SizedBox(
            child: Column(
              children: [
                // CustomContainerTopScreen(
                // ontap: () {
                //   Get.back();
                // },
                // screenUtil: screenUtil,
                // text: 'payment methods'.tr,
                // size: 120,
                // ),
                SizedBox(
                  height: screenUtil.setHeight(30),
                ),
                Expanded(
                  child: GetBuilder<PaymentController>(
                    builder: (_) => InkWell(
                      onTap: () {
                        _controller.selectPatmentType(type: 'credit'.tr);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _controller.credit
                                ? ColorApp.primary.withOpacity(0.5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20).w),
                        child: Container(
                          height: screenUtil.setHeight(120),
                          width: size.width - 40,
                          margin: const EdgeInsets.all(7).w,
                          decoration: buildShadowContainer(
                              borderRadius: BorderRadius.circular(20).w),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenUtil.setWidth(50),
                                  height: screenUtil.setHeight(70),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icons/cards.png'),
                                          fit: BoxFit.contain)),
                                ),
                                SizedBox(
                                  height: screenUtil.setHeight(15),
                                ),
                                Text(
                                  'Credit /Debit Card'.tr,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(50),
                ),
                Expanded(
                  child: GetBuilder<PaymentController>(
                    builder: (_) => InkWell(
                      onTap: () {
                        _controller.selectPatmentType(type: 'recepit'.tr);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _controller.recepit
                                ? ColorApp.primary.withOpacity(0.5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: screenUtil.setHeight(120),
                          width: size.width - 40,
                          margin: const EdgeInsets.all(7).w,
                          decoration: buildShadowContainer(
                              borderRadius: BorderRadius.circular(20).w),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenUtil.setWidth(30),
                                  height: screenUtil.setHeight(50),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/icons/b2c.png'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: screenUtil.setHeight(15),
                                ),
                                Text(
                                  'recepit'.tr,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(100),
                ),
                CustomTextNextButton(
                  totalPrice: orderData['totalPrice'].toString(),
                  onTap: () async {
                    final getOrderData = await _addOrderModel(context: context);

                    if (getOrderData != null) {
                      print(getOrderData.data);
                      if (_controller.recepit) {
                        // ignore: use_build_context_synchronously
                        await showDialog(
                          context: context,
                          builder: (context) => Container(
                            margin: const EdgeInsets.only(bottom: 150).r,
                            child: PopUp(
                              titleFristChat: 'T',
                              titlePartTwo: 'HANKS',
                              image: 'assets/images/json/success_payment.json',
                              orderID: '${getOrderData.data!.id}',
                              btnText: 'Done',
                            ),
                          ),
                        );
                      } else {
                        // print(getOrderData.data);
                        Get.to(
                          () => CheckoutScreen(
                            orderId: getOrderData.data?.id.toString() ?? '',
                            orderData: orderData,
                            serviceModel: serviceInfo,
                          ),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 1000),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }

  Future<AddOrderModel?> _addOrderModel({required BuildContext context}) async {
    return await _orderController.addOrder(
      context: context,
      workArea: orderData['workArea'],
      date: orderData['orderDate'],
      time: orderData['orderTime'],
      address: orderData['address'] ?? '',
      repeat: orderData['repeat'],
      serviceId: serviceInfo.id.toString(),
      subService: orderData['sub_service_id'],
      requirement: orderData['requirement'],
      count: orderData['count'],
      images: orderData['gallery'],
    );
  }
}

