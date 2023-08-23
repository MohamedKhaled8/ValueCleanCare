import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/requriment_controller.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/model/requirement_model.dart';
import 'package:vc/model/services_model/subService_model.dart';
import 'package:vc/view/service_form/service_form_screen.dart';
import '../model/services_model/user_home_model.dart';
import '../theme/constant/const_colors.dart';
import '../view/messages/views/latest_message_screen.dart';

class CustomButtomNavBar extends StatelessWidget {
  final Service? serviceModel;

  const CustomButtomNavBar({
    super.key,
    required this.screenUtil,
    this.ontap,
    required this.serviceModel,
  });
  final Function()? ontap;
  final ScreenUtil screenUtil;

  @override
  Widget build(BuildContext context) {
    final RequrimentController requrimentController =
        Get.put(RequrimentController());

    final UserHomeController extraServiceController =
        Get.put(UserHomeController());
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))
            .r,
      ),
      height: screenUtil.setHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10).w,
            child: InkWell(
              onTap: () {
                Get.to(
                  () => const LatestMessagesScreen(),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 1000),
                );
              },
              child: Container(
                height: screenUtil.setHeight(120),
                width: screenUtil.setWidth(165),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(10).w),
                    color: const Color(0xff004E64)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/icons/chat.png"),
                    Text(
                      "Chat".tr,
                      style: TextStyle(color: Colors.white, fontSize: 22.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10).w,
            child: InkWell(
              onTap: ontap,
              child: Container(
                height: screenUtil.setHeight(120),
                width: screenUtil.setWidth(165),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(10).w),
                    color: ColorApp.primary),
                child: InkWell(
                  onTap: () async {
                    final requrimentData =
                        await requrimentController.requirement(
                            context: context, id: serviceModel!.id.toString());

                    final subServicesData =
                        // ignore: use_build_context_synchronously
                        await extraServiceController.subService(
                            context: context, id: serviceModel!.id.toString());

                    Get.to(
                      () => ServiceFormScreen(
                        serviceModel: serviceModel,
                        requirmentModel: requrimentData ?? RequriementModel(),
                        subServiceModel: subServicesData ?? SubServiceModel(),
                      ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 1000),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Schedule".tr,
                        style:  TextStyle(color: Colors.white, fontSize: 22.sp),
                      ),
                      Image.asset("assets/icons/schedule2.png"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
