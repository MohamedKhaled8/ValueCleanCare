// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/view/map_view/map_screen.dart';
import '../../controller/company/company_register_controller.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import '../../widgets/custom_textform_field.dart';
import '../../widgets/custom_textformfied _password.dart';
import '../../widgets/cutom_buttom_two.dart';
import 'auth_view.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Animation_Controller _controller = Get.put(Animation_Controller());
  final CompanyRegisterController _signController =
      Get.put(CompanyRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Animation_Controller>(
        builder: (_) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenUtil.setHeight(100),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: ArrowBackIcon(
                  ontap: () {
                    Get.to(const AuthAppView());
                  },
                ),
              ),
              Column(
                children: [
                  Text(
                    "Welcome".tr,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorApp.primary),
                  ),
                  Text(
                    "Create your account".tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GetBuilder<CompanyRegisterController>(
                          init: CompanyRegisterController(),
                          builder: (_) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'user',
                                    selected: _.userAccount,
                                    activeColor: ColorApp.primary,
                                    toggleable: _.userAccount,
                                    groupValue: _.groupValue,
                                    onChanged: (value) {
                                      _.checkAccountType(
                                          selectedAccount: value.toString());
                                    },
                                    title: Text(
                                      'user'.tr,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'company',
                                    selected: _.companyAccount,
                                    activeColor: ColorApp.primary,
                                    toggleable: _.companyAccount,
                                    groupValue: _.groupValue,
                                    onChanged: (value) {
                                      _.checkAccountType(
                                          selectedAccount: value.toString());
                                    },
                                    title: Text(
                                      'Company'.tr,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'Shipping Company',
                                    groupValue: _.groupValue,
                                    selected: _.shippingCompanyAccount,
                                    toggleable: _.shippingCompanyAccount,
                                    activeColor: ColorApp.primary,
                                    onChanged: (value) {
                                      _.checkAccountType(
                                          selectedAccount: value.toString());
                                    },
                                    title: Text(
                                      'Shipping Company',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                              right: 30, bottom: 30, left: 30, top: 10)
                          .r,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextFormField(
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Filed Required'.tr;
                                  }
                                  return null;
                                },
                                controller: _signController.name,
                                type: TextInputType.name,
                                text: 'Enter full name'.tr,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              CustomTextFormField(
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Filed Required'.tr;
                                  }
                                  return null;
                                },
                                controller: _signController.phone,
                                type: TextInputType.number,
                                text: 'Enter phone number'.tr,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              CustomTextFormField(
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Filed Required'.tr;
                                  }
                                  return null;
                                },
                                suffixIconOnTap: () async {
                                  try {
                                    _controller.loder();

                                    final status =
                                        await CachingData.getLocation();

                                    if (status) {
                                      Get.to(
                                        () => const MapScreen(
                                          addressIndex: null,
                                        ),
                                        transition: Transition.fadeIn,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Application want Location permission before use the map'
                                            .tr,
                                        style: TextStyle(fontSize: 16.sp),
                                      )));
                                    }
                                  } on LocationServiceDisabledException catch (_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      'Please Enable Location before use the map'
                                          .tr,
                                      style: TextStyle(fontSize: 16.sp),
                                    )));
                                  } finally {
                                    _controller.loder();
                                  }
                                },
                                text: 'Enter Address'.tr,
                                controller: _signController.address,
                                icon: const Icon(
                                  Icons.edit_calendar_outlined,
                                  color: Colors.grey,
                                ),
                                type: TextInputType.name,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              CustomTextFormField(
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Filed Required'.tr;
                                  }
                                  return null;
                                },
                                controller: _signController.email,
                                type: TextInputType.emailAddress,
                                text: 'Enter email'.tr,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              GetBuilder<CompanyRegisterController>(
                                  builder: (_) {
                                if (_.shippingCompanyAccount) {
                                  return Column(
                                    children: [
                                      CustomTextFormField(
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Filed Required';
                                          }
                                          return null;
                                        },
                                        controller: _signController.companyId,
                                        type: TextInputType.text,
                                        text: 'Enter Company Id'.tr,
                                      ),
                                      SizedBox(
                                          height: screenUtil.setHeight(20)),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                              CustomTextFormFieldPassword(
                                text: 'Enter Password'.tr,
                                controllerTwo: _signController.password,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              CustomTextFormFieldPassword(
                                text: 'Confirm password'.tr,
                                controllerTwo:
                                    _signController.passwordConfirmation,
                              ),
                              SizedBox(height: screenUtil.setHeight(20)),
                              CustomButtonTWo(
                                onTap: () async {
                                  try {
                                    _controller.loder();
                                    if (_formKey.currentState!.validate()) {
                                      if (_signController.userAccount) {
                                        await _signController.register(
                                          context: context,
                                        );
                                      } else if (_signController
                                          .companyAccount) {
                                        await _signController.companyRegister(
                                          context: context,
                                        );
                                      } else if(_signController.shippingCompanyAccount){
                                        await _signController
                                            .shippingCompanyRegister(
                                                context: context);
                                      }
                                    }
                                  } finally {
                                    _controller.loder();
                                  }
                                },
                                screenUtil: screenUtil,
                                txt: 'Sign up'.tr,
                                color: ColorApp.primary,
                                color1: Colors.white,
                              ),
                              SizedBox(height: screenUtil.setHeight(10)),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
