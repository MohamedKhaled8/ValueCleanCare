// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vc/animation/animated_scale.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/controller/payment_controller.dart';
import 'package:vc/model/payment/all_payment_mdel.dart';
import 'package:vc/view/payment/change_card_screen.dart';
import 'package:vc/widgets/credet_card.dart';

import '../../../model/services_model/user_home_model.dart';
import '../../../theme/constant/sized.dart';
import '../../../widgets/container_shadow.dart';
import '../../../widgets/custom_containert_top_screen.dart';

class TopStackAppBar extends StatelessWidget {
  final Widget? card;
  final Map PriceOrderCard;
  final Service serviceModel;
  final String orderId;

  const TopStackAppBar({
    Key? key,
    this.card,
    required this.PriceOrderCard,
    required this.serviceModel,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final PaymentController allpaymentController = Get.put(PaymentController());

    // ignore: no_leading_underscores_for_local_identifiers
    final Animation_Controller _controller = Get.put(Animation_Controller());
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: size.width,
          height: size.height / 2 - 120,
        ),
        CustomContainerTopScreen(
          ontap: () {
            Get.back();
          },
          screenUtil: screenUtil,
          text: 'Check Out'.tr,
          size: 150,
        ),
        FutureBuilder(
          future: allpaymentController.allPayment(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              final allPaymentCards = snapshot.data as AllPaymentModel;
              return Positioned(
                top: 100,
                child: Column(
                  children: [
                    Container(
                      width: screenUtil.setWidth(350),
                      height: screenUtil.setHeight(120),
                      decoration: buildShadowContainer(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ).r,
                      ),
                      child: GetBuilder<Animation_Controller>(
                        init: Animation_Controller(),
                        builder: (controller) => AnimatedScaleTapDownUp(
                          initScale: _controller.scale,
                          onTapDownFunx: () => _controller
                              .scaleAnimationTapDownUp(maxScale: 1.15),
                          onTapUpFunx: () => _controller
                              .scaleAnimationTapDownUp(maxScale: 1.15),
                          child: InkWell(
                            onTapDown: (tap) {
                              _controller.scaleAnimationTapDownUp(
                                  maxScale: 1.15);
                            },
                            onTapUp: (tap) {
                              _controller.scaleAnimationTapDownUp(
                                  maxScale: 1.15);
                            },
                            child: card ??
                                CredetCard(
                                  paymentCard: allPaymentCards.data![0],
                                ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                            ChangeCardScreen(
                              orderId: orderId,
                              serviceModel: serviceModel,
                              PriceOrderCard: PriceOrderCard,
                              allPaymentModel: allPaymentCards,
                            ),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 1000));
                      },
                      child: Container(
                        height: screenUtil.setHeight(48),
                        width: screenUtil.setWidth(350),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ).r,
                        ),
                        child: Center(
                          child: Text(
                            'Change Card'.tr,
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
