import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vc/theme/constant/const_colors.dart';
import '../../model/notification/notification_model.dart';
import '../../theme/constant/sized.dart';

class NotificationsCard extends StatelessWidget {
  final Data notificationData;

  const NotificationsCard({super.key, required this.notificationData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).r,
      padding: const EdgeInsets.symmetric(horizontal: 5).r,
      height: screenUtil.setHeight(85),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18).w,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0).w,
        leading: Transform.scale(
          scale: 1.25,
          child: Container(
            margin: const EdgeInsets.only(left: 6).r,
            padding: const EdgeInsets.all(3).w,
            //height: screenUtil.setHeight(90),
            decoration: BoxDecoration(
              color: ColorApp.fav,
              borderRadius: BorderRadius.circular(10).w,
            ),
            child: Image.asset(
              'assets/icons/cleaning 1.png',
            ),
          ),
        ),
        title: Text(
          notificationData.title.toString(),
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorApp.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(notificationData.body.toString(),style: TextStyle(fontSize: 14.sp),),
        trailing: Padding(
          padding:const  EdgeInsets.only(bottom: 24, right: 10).r,
          child: Text(
            notificationData.createdAt.toString(),
            style:  TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
