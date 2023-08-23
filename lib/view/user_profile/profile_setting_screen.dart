// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/animation_controller.dart';
import 'package:vc/controller/auth/change_password_controller.dart';
import 'package:vc/controller/auth/update_profile_controller.dart';
import 'package:vc/model/auth/profile_model.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/user_profile/profile_setting_button.dart';
import 'package:vc/widgets/container_shadow.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';
import '../../../theme/constant/const_colors.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../controller/auth/profile_controller.dart';
import '../../widgets/custom_containert_top_screen.dart';
import '../../widgets/custom_textformfied _password.dart';

class ProfileSettingScreen extends StatefulWidget {
  ProfileModel data;
  ProfileSettingScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
 
  final updateProfileController = Get.put(UpdateProfileController());
  final ProfileController profileController = Get.find();
  final _animationController = Get.put(Animation_Controller());
  final ScrollController _scrollController = ScrollController();
  final ChangePasswordController _changePasswordController =
      ChangePasswordController();

  @override
  void initState() {
    super.initState();
    addAddressToList(addressList: widget.data.userData);
  }

  List<File>? selectedPic = [];

  @override
  Widget build(BuildContext context) {
    _setValues();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<Animation_Controller>(
          builder: (_) => Loder(
            loder: _animationController.loderShow,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height / 2 - 85,
                      ),
                      CustomContainerTopScreen(
                        ontap: () {
                          Get.back();
                        },
                        text: "User Profile".tr,
                        screenUtil: screenUtil,
                        size: 200,
                      ),
                      Positioned(
                        left: 50,
                        right: 50,
                        top: 115,
                        child: Container(
                          height: screenUtil.setHeight(176),
                          width: screenUtil.setWidth(176),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 3,
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: selectedPic!.isEmpty
                                  ? setImage()
                                  : FileImage(File(
                                      selectedPic!.first.path,
                                    )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 47.5.h,
                        left: 179.w,
                        child: InkWell(
                          onTap: () async {
                            selectedPic = await Get.to(
                                () => const WhatsappCamera(multiple: false));
                            setState(() {});
                          },
                          child: Container(
                            height: screenUtil.setHeight(25),
                            width: screenUtil.setWidth(35),
                            decoration: buildShadowContainer(
                                borderRadius: BorderRadius.circular(10).w),
                            child: const Center(
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account'.tr,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          Container(
                            height: screenUtil.setHeight(250),
                            decoration: buildShadowContainer(
                                borderRadius: BorderRadius.circular(20).w),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0).w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      text: 'Enter Your Name'.tr,
                                      controller: _changePasswordController.name,
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined),
                                      type: TextInputType.name,
                                      fieldName: 'name'.tr,
                                    ),
                                    SizedBox(
                                      height: screenUtil.setHeight(10),
                                    ),
                                    CustomTextFormField(
                                      text: 'national identification number'.tr,
                                      controller:  _changePasswordController.number,
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined),
                                      type: TextInputType.number,
                                      fieldName: 'name'.tr,
                                    ),
                                    SizedBox(
                                      height: screenUtil.setHeight(10),
                                    ),
                                    CustomTextFormField(
                                      text: 'Enter Your Email'.tr,
                                      controller: _changePasswordController. email,
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined),
                                      type: TextInputType.emailAddress,
                                      fieldName: 'name'.tr,
                                    ),
                                    SizedBox(
                                      height: screenUtil.setHeight(10),
                                    ),
                                    CustomTextFormField(
                                      text: 'Enter Your Number'.tr,
                                      controller:  _changePasswordController.phone,
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined),
                                      type: TextInputType.number,
                                      fieldName: 'name'.tr,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(15),
                          ),
                          Text(
                            'Address'.tr,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          Container(
                            height: screenUtil.setHeight(150),
                            padding: const EdgeInsets.all(10.0).w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ).r,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: addressTextFiled.length,
                              itemBuilder: ((context, index) {
                                return Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5)
                                            .r,
                                    child: addressTextFiled[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                addressTextProfileController
                                    .add(TextEditingController());
                                addressTextFiled.add(
                                  CustomTextFormField(
                                    textFiledIndex: addressTextFiled.length,
                                    suffixIcon: true,
                                    text: 'Address'.tr,
                                    controller:
                                        addressTextProfileController.last,
                                    icon: const Icon(
                                      Icons.edit_calendar_outlined,
                                      color: Colors.grey,
                                    ),
                                    type: TextInputType.name,
                                  ),
                                );
                              });
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                              height: screenUtil.setHeight(80),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ).r,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0).w,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: screenUtil.setHeight(10),
                                    ),
                                    Center(
                                      child: Container(
                                        width: size.width / 2,
                                        height: screenUtil.setHeight(40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5).w,
                                          border: Border.all(
                                              color: ColorApp.primary),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 5)
                                              .r,
                                          child: Row(
                                            children: [
                                              Container(
                                                height:
                                                    screenUtil.setHeight(30),
                                                width: screenUtil.setWidth(30),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorApp.primary),
                                                ),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  color: ColorApp.primary,
                                                )),
                                              ),
                                              SizedBox(
                                                width: screenUtil.setWidth(30),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                ' Add Address'.tr,
                                                style: TextStyle(
                                                    color: ColorApp.primary,
                                                    fontSize: 16.sp),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(10),
                          ),
                          Container(
                            height: screenUtil.setHeight(300),
                            decoration: buildShadowContainer(
                              borderRadius: BorderRadius.circular(20).w,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0).w,
                              child: Column(
                                children: [
                                  CustomTextFormFieldPassword(
                                    text: 'Old password'.tr,
                                    controllerTwo: _changePasswordController. oldPassword,
                                  ),
                                  SizedBox(
                                    height: screenUtil.setHeight(10),
                                  ),
                                  CustomTextFormFieldPassword(
                                    text: 'New password'.tr,
                                    controllerTwo: _changePasswordController. newPassCont,
                                  ),
                                  SizedBox(
                                    height: screenUtil.setHeight(10),
                                  ),
                                  CustomTextFormFieldPassword(
                                    text: 'Confirm password'.tr,
                                    controllerTwo: _changePasswordController. confirmPassCont,
                                  ),
                                  SizedBox(
                                    height: screenUtil.setHeight(20),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        _animationController.loder();
                                        final status =
                                            await _changePasswordController
                                                .changePassword(
                                                    context: context);

                                        if (status) {
                                          _changePasswordController. oldPassword.clear();
                                         _changePasswordController.  newPassCont.clear();
                                         _changePasswordController.  confirmPassCont.clear();
                                        }
                                      } finally {
                                        _animationController.loder();
                                      }
                                    },
                                    child: Container(
                                      height: screenUtil.setHeight(40),
                                      width: screenUtil.setWidth(210),
                                      decoration: BoxDecoration(
                                        color: ColorApp.primary,
                                        borderRadius:
                                            BorderRadius.circular(10).w,
                                      ),
                                      child: Center(
                                        child: Text(
                                          " Change Password".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: ProfileSettingButton(
            onTap: () async {
              try {
                _animationController.loder();

                final List<String> addressList = [];
                for (var element in addressTextProfileController) {
                  addressList.add(element.text);
                }
                widget.data = (await updateProfileController.updateProfile(
                    name:  _changePasswordController.name.text,
                    email:  _changePasswordController.email.text,
                    address: addressList,
                    phone:  _changePasswordController.phone.text,
                    nin: _changePasswordController. number.text,
                    photo:
                        selectedPic!.isNotEmpty ? selectedPic!.first.path : '',
                    context: context))!;
                updateProfileController.update();
                profileController.update();
                Get.back();
              } finally {
                _animationController.loder();
              }
            },
            btnText: 'Save Changes'.tr,
            screenUtil: screenUtil,
            size: size),
      ),
    );
  }

  _setValues() {
    if ( _changePasswordController.name.text == widget.data.userData.name ||  _changePasswordController.name.text.isEmpty) {
       _changePasswordController.name.text = widget.data.userData.name;
    }

    if ( _changePasswordController.email.text == widget.data.userData.email ||  _changePasswordController.email.text.isEmpty) {
       _changePasswordController.email.text = widget.data.userData.email;
    }

    if ( _changePasswordController.phone.text == widget.data.userData.phone.toString() ||
         _changePasswordController.phone.text.isEmpty) {
       _changePasswordController.phone.text = widget.data.userData.phone.toString();
    }

    if ( _changePasswordController.number.text == widget.data.userData.NIN.toString() ||
        _changePasswordController. number.text.isEmpty) {
      _changePasswordController. number.text = widget.data.userData.NIN.toString();
    }
  }

  ImageProvider<Object> setImage() {
    if (widget.data.userData.photo.contains('http')) {
      return NetworkImage(widget.data.userData.photo);
    } else {
      return const AssetImage('assets/images/png/user.png');
    }
  }

  addAddressToList({required UserData addressList}) {
    addressTextProfileController.clear();
    addressTextFiled.clear();
    for (int index = 0; index < addressList.address.length; index++) {
      addressTextProfileController.add(TextEditingController());
      addressTextFiled.add(CustomTextFormField(
        textFiledIndex: index,
        suffixIcon: true,
        text: 'Address'.tr,
        controller: addressTextProfileController.last,
        icon: const Icon(
          Icons.edit_calendar_outlined,
          color: Colors.grey,
        ),
        type: TextInputType.name,
      ));

      addressTextProfileController.last.text =
          addressList.address[index].toString().isNotEmpty
              ? addressList.address[index]
              : 'Address'.tr;
    }
  }
}

List<CustomTextFormField> addressTextFiled = [];

List<TextEditingController> addressTextProfileController = [];
