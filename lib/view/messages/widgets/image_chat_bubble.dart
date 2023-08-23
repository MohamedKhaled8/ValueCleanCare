import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/constant/const_colors.dart';

class ImageChatBubble extends StatelessWidget {
  final String image;
  final bool sender;
  final String id;
  const ImageChatBubble(
      {super.key, required this.image, required this.sender, required this.id});

  @override
  Widget build(BuildContext context) {
    return BubbleNormalImage(
      id: id,
      image: image.contains('http')?Image.network(image):Image.file(File(image)),
      color: sender
          ? ColorApp.primary.withOpacity(0.7)
          : ColorApp.buttonBlue.withOpacity(0.7),
      tail: true,
      isSender: sender,
    );
  }
}
