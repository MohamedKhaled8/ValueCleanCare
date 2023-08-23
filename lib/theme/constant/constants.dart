import 'package:flutter/material.dart';

class ShowBanner {
static  showBanner({required BuildContext context,required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(text)));
  }
}
