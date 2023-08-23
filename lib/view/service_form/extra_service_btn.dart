import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vc/theme/constant/sized.dart';

class ExtraServiceBtn extends StatelessWidget {
  final String text;
  const ExtraServiceBtn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5).r,
      height: screenUtil.setHeight(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5).w,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
