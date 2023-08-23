import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/widgets/popup.dart';

import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import '../../../widgets/container_shadow.dart';
import '../../../widgets/cutom_buttom_two.dart';

class ButtomBar extends StatelessWidget {
  const ButtomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: screenUtil.setHeight(50),
      width: size.width,
      decoration:
          buildShadowContainer(borderRadius: BorderRadius.circular(20).w),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5).r,
        child: CustomButtonTWo(
          screenUtil: screenUtil,
          color: ColorApp.primary,
          color1: Colors.white,
          txt: 'Payment confirmation'.tr,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => Container(
                margin: const EdgeInsets.only(bottom: 150).r,
                child: const PopUp(
                  titleFristChat: 'P',
                  titlePartTwo: 'PAYMENT SUCCESSFULLY',
                  image: 'assets/images/json/success_payment.json',
                  orderID: '165498753',
                  btnText: 'Done',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
