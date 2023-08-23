// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import '../../../widgets/container_shadow.dart';

class PriceOrderCard extends StatelessWidget {
  final Map orderInfo;

  const PriceOrderCard({super.key, required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenUtil.setWidth(315),
          height: screenUtil.setHeight(130),
          decoration: buildShadowContainer(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ).r,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 15, bottom: 10).r,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price Summary'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cleaning'.tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xff1C1C21),
                    ),
                  ),
                  Text(
                    '${orderInfo['totalPrice']} \$',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1C1C21),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 3).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff1C1C21),
                    ),
                  ),
                  Text(
                    r'0 $',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1C1C21),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Container(
            height: screenUtil.setHeight(48),
            width: screenUtil.setWidth(315),
            decoration: BoxDecoration(
              color: ColorApp.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ).r,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total'.tr,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                  Text(
                    '${orderInfo['totalPrice']} \$ ',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}