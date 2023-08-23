// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/controller/auth/rest_password_controller.dart';
import 'package:vc/view/auth_view/login_view.dart';
import 'package:vc/widgets/custom_buttom.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import '../../widgets/custom_textformfied _password.dart';
import 'forgot_password_screen.dart';

class RestPasswordScreen extends StatelessWidget {
  final String? passingEmail;
  RestPasswordScreen({super.key, this.passingEmail});
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RestPasswordController _restPasswordController =
      RestPasswordController();

  final Animation_Controller _animationController = Animation_Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<Animation_Controller>(
      builder: (_) => Loder(
        loder: _animationController.loderShow,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 60).r,
                child: ArrowBackIcon(
                  ontap: () {
                    Get.to(ForgotPasswordView());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80).r,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        "assets/icons/152 - 38 Valu Clean Care Site Logo 02.png"),
                    SizedBox(
                      height: screenUtil.setHeight(10),
                    ),
                    Text(
                      "Slogan for Value cleaning",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(50),
                    ),
                    Text(
                      "Rest password ".tr,
                      style:
                          TextStyle(fontSize: 18.sp, color: ColorApp.primary),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20).w,
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          CustomTextFormFieldPassword(
                            text: 'New password'.tr,
                            controllerTwo: newPassword,
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          CustomTextFormFieldPassword(
                            text: 'Confirm password'.tr,
                            controllerTwo: confirmNewPassword,
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(30),
                          ),
                          CustomButtom(
                            text: 'Change'.tr,
                            color: ColorApp.primary,
                            screenUtil: screenUtil,
                            color1: Colors.white,
                            ontap: () async {
                              try {
                                _animationController.loder();
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                if (formKey.currentState!.validate()) {
                                  if (newPassword.text ==
                                      confirmNewPassword.text) {
                                    await _restPasswordController.restPassword(
                                        email: passingEmail ?? '',
                                        newPassword: newPassword.text,
                                        confirmPassword:
                                            confirmNewPassword.text,
                                        context: context);
                                    Get.off(
                                        () => LoginView(
                                              passEmail: passingEmail,
                                              passpassword: newPassword.text,
                                            ),
                                        transition: Transition.fade,
                                        duration:
                                            const Duration(milliseconds: 1000));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      'Passwords Not Matches'.tr,
                                      style: TextStyle(fontSize: 16.sp),
                                    )));
                                  }
                                }
                              } finally {
                                _animationController.loder();
                              }
                            },
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(30),
                          ),
                        ]),
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
