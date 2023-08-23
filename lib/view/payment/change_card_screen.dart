// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/change_card_controller.dart';
import 'package:vc/model/payment/all_payment_mdel.dart';

import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/payment/checkout_view/checkout_screen.dart';
import 'package:vc/widgets/credet_card.dart';

import '../../model/services_model/user_home_model.dart';
import '../../widgets/cutom_buttom_two.dart';
import '../../widgets/default_appBar.dart';

class ChangeCardScreen extends StatelessWidget {
  final AllPaymentModel allPaymentModel;
  final Map PriceOrderCard;
  final Service serviceModel;
  final String orderId;

  ChangeCardScreen({
    Key? key,
    required this.allPaymentModel,
    required this.PriceOrderCard,
    required this.serviceModel,
    required this.orderId,
  }) : super(key: key);

  final controller = Get.put(ChangeCardController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
            ontap: () {
              Get.back();
            },
            text: 'Change Card '.tr,
            screenUtil: screenUtil,
            size: 130),
        backgroundColor: const Color(0xffF0F0F0),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: allPaymentModel.data!.length,
                  itemBuilder: (cotext, index) {
                    return InkWell(onTap: () {
                      controller.checkSelected(cardIndex: index, active: true);
                    }, child: GetBuilder<ChangeCardController>(
                      builder: (_) {
                        return Container(
                          width: screenUtil.setWidth(350),
                          height: screenUtil.setHeight(130),
                          margin: const EdgeInsets.all(10).w,
                          decoration: BoxDecoration(
                            color: _.isSelected
                                ? _.cardSelected == index
                                    ? ColorApp.primary.withOpacity(0.3)
                                    : null
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(15).w),
                          ),
                          child: CredetCard(
                            paymentCard: allPaymentModel.data![index],
                          ),
                        );
                      },
                    ));
                  }),
            ),
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
                txt: 'Select Card'.tr,
                onTap: () {
                  Get.off(CheckoutScreen(
                    orderId: orderId,
                    serviceModel: serviceModel,
                    orderData: PriceOrderCard,
                    card: CredetCard(
                      paymentCard:
                          allPaymentModel.data![controller.cardSelected],
                    ),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}

List<CredetCard> credetCard = [];
