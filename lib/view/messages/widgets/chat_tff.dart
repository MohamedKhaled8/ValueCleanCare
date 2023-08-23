import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/chat/chat_controller.dart';

import '../../../theme/constant/const_colors.dart';


// ignore: must_be_immutable
class ChatTff extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final Function(String value) onChange;
  const ChatTff({
    super.key,
    required this.hintText,
    required this.textController,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: GetBuilder<ChatController>(builder: (controller) {
        return TextField(
          onChanged: onChange,
          textDirection: TextDirection.ltr,
          controller: textController,
          maxLines: 1,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            fillColor: Colors.grey.withOpacity(0.1),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20.sp),
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10).w),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10).w),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10).w),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10).w),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10).w),
            focusColor: ColorApp.primary,
          ),
        );
      }),
    );
  }
}
