// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/model_card.dart';

class CardView extends StatelessWidget {
  final ModelCard modelCard;
  final Color backgroundColor;
  const CardView({
    Key? key,
    required this.modelCard,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10).r,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: setImage(),
          fit: BoxFit.cover,
        ),
      ),
      child: DefaultTextStyle(
        style:  TextStyle(color: Colors.white, fontSize: 22.0.sp),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40).r,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      modelCard.title!,
                      style:  TextStyle(fontSize: 32.sp),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic setImage() {
    if (modelCard.image != null && modelCard.image!.contains('http')) {
      return NetworkImage(modelCard.image!);
    } else {
      const AssetImage('assets/images/png/Rectangle 10.png');
    }
  }
}
