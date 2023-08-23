// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/constant/const_colors.dart';
import 'arrow_back_icons.dart';

class DefaultAppBar extends StatelessWidget
    implements PreferredSize {
  final String text;
  final ScreenUtil screenUtil;
  double? size;
  final Function()? ontap;

  DefaultAppBar({
    Key? key,
    required this.text,
    required this.screenUtil,
     this.size=120,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: ontap,
        child: const ArrowBackIcon(
          color: Colors.white,
        ),
      ),
      flexibleSpace: Container(
          height: screenUtil.setHeight(size!),
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorApp.primary,
              borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))
                  .w)),
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
        ),
      ),
      titleSpacing: 0.0,
      backgroundColor: ColorApp.primary,
      automaticallyImplyLeading: false,
      toolbarHeight: screenUtil.setHeight(130),
      shape: CustomShapeBorder(),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(screenUtil.setHeight(size!));
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double radius = 20.0.sp; // Adjust the radius as needed
    final Path path = Path()
      ..moveTo(rect.left, rect.top)
      ..lineTo(rect.left, rect.bottom - radius)
      ..arcToPoint(
        Offset(rect.left + radius, rect.bottom),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(rect.right - radius, rect.bottom)
      ..arcToPoint(
        Offset(rect.right, rect.bottom - radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(rect.right, rect.top)
      ..close();
    return path;
  }
}
