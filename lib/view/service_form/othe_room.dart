import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/service_form_controller.dart';

import '../../theme/constant/const_colors.dart';
import '../../widgets/container_shadow.dart';

class BuildOtherItems extends StatelessWidget {
  final String roomName;
  final String roomPrice;
  final int btnNum;
  final int price;
  final int index;
  BuildOtherItems(
      {Key? key,
      required this.roomName,
      required this.roomPrice,
      required this.btnNum,
      required this.price,
      required this.index})
      : super(key: key);
  final ScreenUtil screenUtil = ScreenUtil();
  final ServiceFormController controller = Get.put(ServiceFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 38.sp),
              children: <TextSpan>[
                TextSpan(
                  text: roomName,
                  style: TextStyle(
                    fontSize: 38.sp,
                  ),
                ),
                TextSpan(
                  text: roomPrice,
                  style: TextStyle(fontSize: 29.sp, color: Colors.grey),
                ),
              ],
            ),
            textScaleFactor: 0.5,
          ),
          Container(
            height: screenUtil.setHeight(40),
            width: screenUtil.setWidth(135),
            decoration:
                buildShadowContainer(borderRadius: BorderRadius.circular(10).w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (controller.countRequirementList[index] > 0) {
                      controller.roomMinus(
                        btnNum: btnNum,
                        price: price,
                        index: index,
                      );
                    }
                  },
                  child: Container(
                    height: screenUtil.setHeight(40),
                    width: screenUtil.setWidth(40),
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: BorderRadius.circular(10).w,
                    ),
                    child: Center(
                      child: Image.asset('assets/icons/minus.png'),
                    ),
                  ),
                ),
                Text('${controller.countRequirementList[index]}'),
                InkWell(
                  onTap: () {
                    controller.roomPlus(
                      btnNum: btnNum,
                      price: price,
                      index: index,
                    );
                  },
                  child: Container(
                    height: screenUtil.setHeight(40),
                    width: screenUtil.setWidth(40),
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: BorderRadius.circular(10).w,
                    ),
                    child: Center(
                      child: Image.asset('assets/icons/add.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
