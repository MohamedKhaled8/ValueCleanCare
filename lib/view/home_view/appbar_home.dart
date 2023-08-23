import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/view/transport_view/service%20_name_transportr.dart';
import 'package:vc/view/notifications/notifications_screen.dart';
import 'package:vc/view/user_profile/user_profile.dart';

class AppBarHome extends StatelessWidget {
  final String? userName;
  final String? userImage;
  final bool user;
  final int notificatioCount;
  const AppBarHome({
    super.key,
    this.userName,
    this.userImage,
    required this.screenUtil,
    required this.user,
    required this.notificatioCount,
  });

  final ScreenUtil screenUtil;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            checkNameLength(userName: userName ?? ''),
            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Need Some Help ?".tr,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ]),
        const Spacer(),
        user
            ? InkWell(
                onTap: () {
                  Get.to(
                    NotificationsView(),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 1000),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: screenUtil.setHeight(50),
                      width: screenUtil.setWidth(50),
                      child: Image.asset("assets/icons/bell.png"),
                    ),
                    notificatioCount > 0
                        ? Positioned(
                            top: 7,
                            left: 7,
                            child: Container(
                              height: screenUtil.setHeight(18),
                              width: screenUtil.setWidth(18),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10).w),
                              child: Text(
                                notificatioCount.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    height: 1.30),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ))
            : const SizedBox(),
        InkWell(
          onTap: () {
            if (user) {
              Get.to(
                UserProfileScreen(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 1000),
              );
            } else {
              Get.to(
                () => ServiceNameTransport(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 1000),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.8,
                )),
            child: CircleAvatar(
              radius: 30.r,
              backgroundImage: setImage(),
              backgroundColor: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }

  ImageProvider<Object>? setImage() {
    if (userImage != null && userImage!.contains('http')) {
      return NetworkImage(userImage!);
    } else {
      return AssetImage(userImage!);
    }
  }

  String checkNameLength({required String userName}) {
    if (userName.length > 13) {
      return '${userName.substring(0, 11)}...';
    } else {
      return userName;
    }
  }
}
