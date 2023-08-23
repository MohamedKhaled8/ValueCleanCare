import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

import '../../../theme/constant/const_colors.dart';


class TextChatBubble extends StatelessWidget {
  final String message;
  final bool sender;
 const  TextChatBubble(
      {super.key, required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: message,
      color: sender ? ColorApp.primary.withOpacity(0.9) : Colors.blue,
      tail: false,
      isSender: sender,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
