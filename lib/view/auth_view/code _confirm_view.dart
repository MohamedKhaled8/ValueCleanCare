// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/controller/auth/code_confirm_controller.dart';
import 'package:vc/controller/auth/forget_password_controller.dart';
import 'package:vc/view/auth_view/rest_password.dart';
import 'package:vc/widgets/custom_buttom.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import '../../widgets/custom_textform_field.dart';
import 'forgot_password_screen.dart';

// ignore: must_be_immutable
class CodeConfirmView extends StatelessWidget {
  final String? passingEmail;
  CodeConfirmView({super.key, this.passingEmail});

  // ignore: unused_field
  final TextEditingController code = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Animation_Controller _controller = Get.put(Animation_Controller());
  final CodeConfirmController _codeController = CodeConfirmController();
  final ForgetPasswordController _resendController = ForgetPasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<Animation_Controller>(
      builder: (_) => Loder(
        loder: _controller.loderShow,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40).r,
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
                    Text(
                      "Slogan for Value cleaning",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(70),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27).r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "we send code to verify your email ".tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20).r,
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          CustomTextFormField(
                            text: 'Enter code '.tr,
                            controller: code,
                            type: TextInputType.name,
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return 'Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(30),
                          ),
                          CustomButtom(
                            text: 'Confirm'.tr,
                            color: ColorApp.primary,
                            screenUtil: screenUtil,
                            color1: Colors.white,
                            ontap: () async {
                              try {
                                _controller.loder();
                                if (formKey.currentState!.validate()) {
                                  final status =
                                      await _codeController.checkCode(
                                    context: context,
                                    email: passingEmail!,
                                    code: code.text,
                                  );

                                  if (status) {
                                    Get.off(
                                      () => RestPasswordScreen(
                                        passingEmail: passingEmail!,
                                      ),
                                      transition: Transition.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                    );
                                  }
                                }
                              } finally {
                                _controller.loder();
                              }
                            },
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(30),
                          ),
                          Text(
                            "didn't receive the code ?".tr,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          InkWell(
                            onTap: () async {
                              _controller.loder();

                              await _resendController.forgetPassword(
                                context: context,
                                email: passingEmail!,
                              );

                              _controller.loder();
                            },
                            child: Text(
                              "resend code".tr,
                              style: TextStyle(
                                  fontSize: 18.sp, color: ColorApp.primary),
                            ),
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
