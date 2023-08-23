import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vc/theme/constant/sized.dart';

class Loder extends StatelessWidget {
  final bool loder;
  final Widget child;
  const Loder({super.key, required this.loder, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        loder
            ? Container(
                height: screenUtil.screenHeight,
                width: screenUtil.screenWidth,
                color: Colors.greenAccent.withOpacity(0.05),
                child: Transform.scale(
                    scale: 0.5,
                    child: Lottie.asset('assets/icons/bar-loader.json')),
              )
            : const SizedBox(),
      ],
    );
  }
}
