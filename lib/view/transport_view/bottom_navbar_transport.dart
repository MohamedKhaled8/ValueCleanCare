import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';

class BottomNavBarTransport extends StatelessWidget {
  final String cpmpanyEmail;
  final String companyPhone;
  const BottomNavBarTransport({
    super.key,
    required this.cpmpanyEmail,
    required this.companyPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))
            .r,
      ),
      height: screenUtil.setHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10).w,
            child: InkWell(
              onTap: () {
                sendMail(uri: 'mailto:$cpmpanyEmail');
              },
              child: Container(
                height: screenUtil.setHeight(120),
                width: screenUtil.setWidth(165),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff004E64)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/icons/emailicon.png"),
                    Text(
                      "E-mail".tr,
                      style: TextStyle(color: Colors.white, fontSize: 22.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                makePhoneCall(phoneNumber: companyPhone);
              },
              child: Container(
                height: screenUtil.setHeight(120),
                width: screenUtil.setWidth(165),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(10).w),
                    color: ColorApp.primary),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/icons/phonecall.png"),
                    Text(
                      "Call".tr,
                      style: TextStyle(color: Colors.white, fontSize: 22.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

sendMail({required String uri}) async {
  // const uri =
  //     'mailto:test@example.org?subject=Greetings&body=Hello%20World';
  if (await canLaunchUrl(Uri.parse(uri))) {
    await launchUrl(Uri.parse(uri));
  } else {
    throw 'Could not launch $uri';
  }
}

Future<void> makePhoneCall({required String phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
