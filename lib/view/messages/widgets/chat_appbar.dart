// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/auth/profile_controller.dart';
import 'package:vc/controller/chat/chat_controller.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/constants.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/video_call/video_call.dart';
import 'package:vc/widgets/arrow_back_icons.dart';

import '../../home_view/bottom_nav_bar.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = ProfileController();
    final ChatController chatController = ChatController();
    return Container(
      height: screenUtil.setHeight(125),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
              .w),
      child: Padding(
        padding: const EdgeInsets.all(15.0).w,
        child: Row(
          children: [
            ArrowBackIcon(
              ontap: () {
                Get.offAll(() => const BottomNavBar(initialIndex: 3,));
              },
            ),
            Container(
              height: screenUtil.setHeight(85),
              width: screenUtil.setWidth(70),
              padding: const EdgeInsets.all(5).w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorApp.primary.withOpacity(0.3)),
              child: Image.asset("assets/icons/cleaning 1.png"),
            ),
            SizedBox(
              width: screenUtil.setHeight(15),
            ),
            Text(
              "Valu Clean Care".tr,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: screenUtil.setHeight(90),
            ),
            InkWell(
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Testing'.tr,
                    style: TextStyle(fontSize: 18.sp),
                  )));
                  final userProfileData =
                      await profileController.getProfileData();

                  // ignore: use_build_context_synchronously
                  final token = await chatController.getVideoCallToken(
                      channelName: 'Value-clean${userProfileData!.userData.id}',
                      context: context);
                  final engine = createAgoraRtcEngine();
                  await engine.initialize(const RtcEngineContext(
                    appId: "67fe9c8bc05147859014018c7243c854",
                    channelProfile:
                        ChannelProfileType.channelProfileLiveBroadcasting,
                  ));
                  ShowBanner.showBanner(
                      context: context,
                      text: token?['channel'.tr] ?? 'No Data');
                  if (token != null) {
                    Get.to(
                        () => VideoCallScreen(
                              rtcEngine: engine,
                              channelName: token['channel'],
                              userName: userProfileData.userData.name,
                              token: token['token'],
                            ),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 1000));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10).w,
                  child: Image.asset("assets/icons/video.png"),
                )),
          ],
        ),
      ),
    );
  }
}
