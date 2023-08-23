// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/auth/profile_controller.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/auth/profile_model.dart';
import 'package:vc/view/user_profile/user_profile_card.dart';
import 'package:vc/widgets/custom_containert_top_screen.dart';
import '../../model/services_model/user_home_model.dart';
import '../../theme/constant/sized.dart';


class ShippingClientProfileScreen extends StatelessWidget {
  final Service? serviceModel;
  final ProfileController profileController = Get.put(ProfileController());
  String? userImage;

  ShippingClientProfileScreen({super.key, this.serviceModel});

  final UserHomeController homeController = UserHomeController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: GetBuilder<ProfileController>(builder: (_) {
      return FutureBuilder(
        future: profileController.getProfileData(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final ProfileModel data = snapshot.data as ProfileModel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomContainerTopScreen(
                          text: "User Profile".tr,
                          screenUtil: screenUtil,
                          size: 215,
                        ),
                        Positioned(
                            left: 114,
                            top: 133,
                            child: CircleAvatar(
                              radius: 80.sp,
                              backgroundImage:
                                  NetworkImage(data.userData.photo),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  Text(
                    data.userData.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(5),
                  ),
                  Text(
                    data.userData.email,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                 
                  SizedBox(
                    height: screenUtil.setHeight(30),
                  ),
                  UserProfileCard(
                    data: data,
                    size: size,
                    screenUtil: screenUtil,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      );
    }));
  }

  ImageProvider<Object> setImage() {
    if (loginData!.userData.photo.contains('http')) {
      return NetworkImage(loginData!.userData.photo);
    } else {
      return const AssetImage('assets/images/png/user.png');
    }
  }
}
