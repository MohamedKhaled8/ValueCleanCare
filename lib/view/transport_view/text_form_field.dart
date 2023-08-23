// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/widgets/custom_textform_field.dart';

import '../../helper/caching_data.dart';

class FormFieldTransport extends StatelessWidget {
  const FormFieldTransport({
    super.key,
    required GlobalKey<FormState> forKey,
    required this.emailTransport,
    required this.numberTransport,
    required this.adressTransport,
    required this.companyidTransport,
  }) : _forKey = forKey;

  final GlobalKey<FormState> _forKey;
  final TextEditingController emailTransport;
  final TextEditingController numberTransport;
  final TextEditingController adressTransport;
  final TextEditingController companyidTransport;
  @override
  Widget build(BuildContext context) {
    setData();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "E-mail".tr,
          style: TextStyle(fontSize: 18.sp, color: ColorApp.primary),
        ),
        SizedBox(
          height: screenUtil.setHeight(10),
        ),
        SingleChildScrollView(
          child: Form(
              key: _forKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      enable: false,
                      controller: emailTransport,
                      validate: (value) {
                        if ( value!.isEmpty) {
                          return 'Required'.tr;
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      text: 'Enter email'.tr,
                    ),
                    SizedBox(height: screenUtil.setHeight(10)),
                    Text(
                      "Phone Number".tr,
                      style:
                          TextStyle(fontSize: 18.sp, color: ColorApp.primary),
                    ),
                    SizedBox(height: screenUtil.setHeight(10)),
                    CustomTextFormField(
                      enable: false,
                      controller: numberTransport,
                      validate: (value) {
                        if ( value!.isEmpty) {
                          return 'Required'.tr;
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      text: 'Enter Yor Number-'.tr,
                    ),
                    SizedBox(height: screenUtil.setHeight(15)),
                    Text(
                      "Address".tr,
                      style:
                          TextStyle(fontSize: 18.sp, color: ColorApp.primary),
                    ),
                    SizedBox(height: screenUtil.setHeight(10)),
                    TextFormField(
                      enabled: false,
                      controller: adressTransport,
                      // controller: ,
                      validator: (value) {
                        if ( value!.isEmpty) {
                          return 'Required'.tr;
                        } 
                        return null;
                      },
                      autofocus: false,
                      // controller: controller,
                      textInputAction: TextInputAction.next,
                      onSaved: (newValue) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(10).w,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).w,
                            borderSide:
                                const BorderSide(width: 1, color: Colors.green),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).w,
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).w,
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).w,
                            borderSide:
                                BorderSide(width: 1, color: ColorApp.primary),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20).r,
                          hintText: "Enter address".tr,
                          hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: Image.asset(
                            "assets/icons/maps.png",
                          )),
                    ),
                    SizedBox(height: screenUtil.setHeight(15)),
                    Text(
                      "Company ID".tr,
                      style:
                          TextStyle(fontSize: 18.sp, color: ColorApp.primary),
                    ),
                    SizedBox(height: screenUtil.setHeight(10)),
                    CustomTextFormField(
                      enable: false,
                      controller: companyidTransport,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required'.tr;
                        }
                        return null;
                      },
                      type: TextInputType.emailAddress,
                      text: 'Enter Company Id'.tr,
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }

  setData() {
    emailTransport.text = loginData!.userData.email;
    numberTransport.text = loginData!.userData.phone.toString();
    adressTransport.text = loginData!.userData.address;
    companyidTransport.text = loginData!.userData.niN.toString();
  }
}
