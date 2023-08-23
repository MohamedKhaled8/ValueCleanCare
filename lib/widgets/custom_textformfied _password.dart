// ignore_for_file: file_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vc/controller/auth/login_controller.dart';
import 'package:vc/theme/constant/const_colors.dart';


class CustomTextFormFieldPassword extends StatelessWidget {
  final controller = Get.put(LoginController());
  final String text;
  final TextEditingController? controllerTwo;
  CustomTextFormFieldPassword({
    Key? key,
    required this.text,
    this.controllerTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Filed Required'.tr;
          }
          return null;
        },
        autofocus: false,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        obscureText: controller.isPasswordHidden.value,
        controller: controllerTwo,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              controller.isPasswordHidden.value =
                  !controller.isPasswordHidden.value;
            },
            child: Icon(
              controller.isPasswordHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: ColorApp.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.green),
            borderRadius: BorderRadius.circular(10).w,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10).w,
            borderSide: const BorderSide(width: 1, color: Colors.green),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10).w,
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10).w,
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20).r,
          hintText: text,
          hintStyle: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
        ),
      );
    });
  }
}
