
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/constant/sized.dart';

class ImageCard extends StatelessWidget {
  final String filePath;
  const ImageCard({super.key, required this.filePath});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InteractiveViewer(
      child: Container(
        height: screenUtil.setHeight(150),
        width: size.width / 2 - 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20).w,
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 20, 20, 20),
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20).w,
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}