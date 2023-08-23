import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/constant/const_colors.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/container_shadow.dart';

class BuildItemCard extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;
  const BuildItemCard({Key? key, required this.image, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap:onTap,
        child: Container(
          width: size.width,
          height: screenUtil.setHeight(50),
          decoration:
          buildShadowContainer(borderRadius: BorderRadius.circular(10).w),
          child: Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Row(
              children: [
                Image.asset(image),
                SizedBox(
                  width: screenUtil.setWidth(10),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 18.sp, color: ColorApp.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
