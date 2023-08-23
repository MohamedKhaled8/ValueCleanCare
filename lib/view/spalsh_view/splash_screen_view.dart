import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:vc/helper/db_sh.dart';
import 'package:vc/helper/secure_storage.dart';
import 'package:vc/services/localizatoion_service.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/auth_view/login_view.dart';
import 'package:vc/widgets/container_shadow.dart';
import '../../widgets/custom_buttom.dart';
import '../onboarding_screen_view/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? seclected;
  List<String> langs = [
    "English 🇬🇧",
    "Swide 🇸🇪",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  "assets/icons/152 - 38 Valu Clean Care Site Logo 02.png"),
              SizedBox(
                height: screenUtil.setHeight(10),
              ),
              Text(
                "Welcome To ValU Clean Care",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(
                height: screenUtil.setHeight(40),
              ),
              Image.asset(
                "assets/icons/626 - 626 Character Valu Clean.png",
                height: screenUtil.setHeight(270),
                width: screenUtil.setHeight(310),
              ),
              SizedBox(
                height: screenUtil.setHeight(30),
              ),
              Container(
                width: screenUtil.setWidth(308),
                height: screenUtil.setHeight(55),
                decoration: buildShadowContainer(
                    borderRadius: BorderRadius.circular(10).w),
                child: Padding(
                  padding: const EdgeInsets.all(10.0).w,
                  child: DropdownButton<String>(
                      hint: Row(
                        children: [
                          Image.asset("assets/icons/Language.png"),
                          SizedBox(
                            width: screenUtil.setWidth(20),
                          ),
                          Text(
                            "Language",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ],
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                      underline: const SizedBox(),
                      value: seclected,
                      isExpanded: T,
                      items:
                          langs.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style:  TextStyle(fontSize: 22.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          seclected = value.toString();
                        });
                      }),
                ),
              ),
              SizedBox(
                height: screenUtil.setHeight(30),
              ),
              CustomButtom(
                  screenUtil: screenUtil,
                  text: 'Start'.tr,
                  color: Colors.green,
                  color1: Colors.white,
                  width: 310,
                  height: 60,
                  ontap: () async {
                    Get.find<LocaleService>().changeLocale(
                      langs[0] == seclected
                          ? Language.english
                          : Language.swedish,
                    );

                    if (langs[0] == seclected) {
                      await Shared_Preference.setData(key: 'lang', value: 'EN');
                    } else if (langs[1] == seclected) {
                      await Shared_Preference.setData(key: 'lang', value: 'SV');
                    } else {
                      await Shared_Preference.setData(key: 'lang', value: 'EN');
                    }
                    final userData =
                        await Secure_Storage.getData(key: 'userLoginData');
                    if (userData != null ||
                        FirebaseAuth.instance.currentUser != null) {
                      Get.off(
                        () => LoginView(),
                        transition: Transition.fade,
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      Get.to(
                        () => const OnBoardingScreen(),
                        duration: const Duration(milliseconds: 1000),
                        transition: Transition.zoom,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
