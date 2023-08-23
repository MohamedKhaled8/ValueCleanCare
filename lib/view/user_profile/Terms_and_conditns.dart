// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/terms_conditions_controller/terms_conditions.dart';
import 'package:vc/model/auth/terms_conditions_model.dart';
import 'package:vc/theme/constant/sized.dart';
import '../../widgets/default_appBar.dart';

class Termsandconditns extends StatelessWidget {
  Termsandconditns({super.key});
  final TermsConditionsController termsConditionsController =
      Get.put(TermsConditionsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: DefaultAppBar(
            ontap: () {
              Get.back();
            },
            text: "Terms and conditns".tr,
            screenUtil: screenUtil,
            size: 130,
          ),
          body: FutureBuilder(
              future:
                  termsConditionsController.termsConditions(context: context),
              builder: ((context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final TermsAndConditionsModel termsandconditns =
                      snapshot.data as TermsAndConditionsModel;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                            .r,
                    child: Text(
                      termsandconditns.termsAndConditions,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }))),
    );
  }
}
