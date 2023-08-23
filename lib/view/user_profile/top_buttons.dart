import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vc/theme/constant/sized.dart';

class TopButtons extends StatelessWidget {
  final String text;
  final String image;
  final Color cardColor;
  final VoidCallback onTapFunx;
  const TopButtons({
    super.key,
    required this.text,
    required this.image,
    required this.cardColor,
    required this.onTapFunx,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunx,
      child: Container(
        height: screenUtil.setHeight(65),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15).w,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.5).w,
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    text,
                    style:  TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                width: screenUtil.setWidth(20),
              ),
              Transform.scale(
                scale: 0.8,
                child: Image.asset(image),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
