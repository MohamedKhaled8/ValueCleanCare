// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/controller/auth/forget_password_controller.dart';
import 'package:vc/view/auth_view/code%20_confirm_view.dart';

import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import '../../widgets/custom_textform_field.dart';
import '../../widgets/cutom_buttom_two.dart';

// ignore: must_be_immutable
class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final Animation_Controller _controller = Get.put(Animation_Controller());
  final ForgetPasswordController _forgetController = ForgetPasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<Animation_Controller>(
      builder: (_) => Loder(
        loder: _controller.loderShow,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 40)
                          .r,
                  child: ArrowBackIcon(
                    ontap: () {
                      Get.back();
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
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(30),
                      ),
                      Text(
                        "Forgot password ?".tr,
                        style:
                            TextStyle(fontSize: 20.sp, color: ColorApp.primary),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      Text(
                        "Dont Worry! it's happening ".tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(40),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30).w,
                        child: Form(
                          child: Column(children: [
                            CustomTextFormField(
                              type: TextInputType.text,
                              controller: email,
                              text: 'Enter email/ Phone number'.tr,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: screenUtil.setHeight(40),
                            ),
                            CustomButtonTWo(
                              onTap: () async {
                                try {
                                  _controller.loder();

                                  if (_formKey.currentState!.validate()) {
                                    final result = ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Check your inbox'),
                                      ),
                                    );
                                    final status =
                                        await _forgetController.forgetPassword(
                                      email: email.text,
                                      context: context,
                                    );

                                    if (status &&
                                        result !=
                                            SnackBarClosedReason.dismiss) {
                                      Get.off(
                                        () => CodeConfirmView(
                                          passingEmail: email.text,
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
                              screenUtil: screenUtil,
                              txt: 'Submit'.tr,
                              color: ColorApp.primary,
                              color1: Colors.white,
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
      ),
    ));
  }
}
