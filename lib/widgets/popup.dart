import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/home_view/bottom_nav_bar.dart';

class PopUp extends StatelessWidget {
  final String? title;
  final String titleFristChat;
  final String titlePartTwo;
  final String image;
  final String? orderID;
  final String btnText;

  const PopUp({
    super.key,
    this.title,
    required this.image,
    this.orderID,
    required this.btnText,
    required this.titleFristChat,
    required this.titlePartTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17).w,
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30).r,
              child: title == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20).r,
                      child: Text(
                        titleFristChat + titlePartTwo.toUpperCase(),
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorApp.primary,
                        ),
                      ),
                    )
                  : Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorApp.primary,
                      ),
                    )),
          LottieBuilder.asset(image),
          orderID != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order Code :  ',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorApp.grey,
                      ),
                    ),
                    Text(
                      orderID!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorApp.primary,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          InkWell(
            onTap: () {
              Get.offAll(() => const BottomNavBar());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30).r,
              alignment: Alignment.center,
              height: screenUtil.setHeight(46),
              width: screenUtil.setWidth(250),
              decoration: BoxDecoration(
                  color: ColorApp.primary,
                  borderRadius: BorderRadius.circular(11).w),
              child: Text(
                btnText,
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
