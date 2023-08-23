// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/company/company_register_controller.dart';
import 'package:vc/controller/myController.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/transport_view/bottom_navbar_transport.dart';
import 'package:vc/view/transport_view/text_form_field.dart';
import 'package:vc/widgets/arrow_back_icons.dart';

class ServiceNameTransport extends StatelessWidget {

  ServiceNameTransport({
    super.key,
  });

  final controller = Get.put(MyController());
  final TextEditingController emailTransport = TextEditingController();
  final TextEditingController numberTransport = TextEditingController();
  final TextEditingController addressTransport = TextEditingController();
  final TextEditingController companyidTransport = TextEditingController();
  final GlobalKey<FormState> _forKey = GlobalKey();
  final CompanyRegisterController registerController =
      CompanyRegisterController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: screenUtil.setHeight(300),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/icons/backg1.jpg"),
                    fit: BoxFit.cover,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                          .r,
                  child: ArrowBackIcon(
                    color: Colors.white,
                    ontap: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 15).r,
              width: double.infinity,
              height: screenUtil.setHeight(500),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))
                      .r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loginData!.userData.name,
                      style: TextStyle(
                          fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenUtil.setHeight(20)),
                    FormFieldTransport(
                        forKey: _forKey,
                        emailTransport: emailTransport,
                        numberTransport: numberTransport,
                        adressTransport: addressTransport,
                        companyidTransport: companyidTransport),
                    SizedBox(height: screenUtil.setHeight(25)),
                  ],
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomNavBarTransport(
          companyPhone: loginData!.userData.phone.toString(),
          cpmpanyEmail: loginData!.userData.email,
        ),
      ),
    );
  }
}
