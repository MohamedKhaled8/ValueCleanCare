
// ignore_for_file: empty_catches

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

import '../../controller/sample_screen_controller.dart';
import '../../theme/constant/const_colors.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    final SampleScreenController sampleScreenController = Get.find();
    ScreenUtil screenUtil = ScreenUtil();
    Size size = MediaQuery.of(context).size;
    return Container(
      height: screenUtil.setHeight(180),
      width: size.width / 2 - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20).w,
        border:
            Border.all(color: Colors.black, width: 1, style: BorderStyle.none),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20).w,
        padding: const EdgeInsets.all(10).w,
        strokeWidth: 2,
        color: ColorApp.grey,
        dashPattern: const [8, 8, 8, 8],
        child: InkWell(
          onTap: () async {
            try {
              sampleScreenController.samplesImages.addAll(await Get.to(
                () => const WhatsappCamera(),
              ));
              sampleScreenController.updateUi();
            } catch (e) {}
          },
          child: Container(
            height: screenUtil.setHeight(150),
            width: size.width / 2 - 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20).w,
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 55,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

