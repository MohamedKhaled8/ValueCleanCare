import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/constant/const_colors.dart';
import '../theme/constant/sized.dart';

class CustomTextNextButton extends StatelessWidget {
  final Function()? onTap;
  final String? totalPrice;
  final bool orderEditing;
  const CustomTextNextButton(
      {Key? key, this.onTap, this.totalPrice, this.orderEditing = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: screenUtil.setHeight(70),
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$totalPrice \$',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: ColorApp.primary),
          ),
          SizedBox(
            width: screenUtil.setWidth(30),
          ),
          Container(
              height: screenUtil.setHeight(50),
              width: screenUtil.setWidth(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).w,
                color: ColorApp.primary,
              ),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      orderEditing ? 'Save Edit'.tr : "Next".tr,
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    Image.asset("assets/icons/schedule2.png")
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
