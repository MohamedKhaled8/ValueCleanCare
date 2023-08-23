// ignore_for_file: file_names

import 'package:get/get.dart';

class MyController extends GetxController {
  bool isShowMore = true;

  bool favoriut = false;
  void isShowMoree() {
    isShowMore = !isShowMore;
    update();
  }

  bool isPressed = false;
  void favo() {
    isPressed = !isPressed;
    update();
  }

  @override
  void onInit() {
    // isStare();
    isShowMoree();
    super.onInit();
  }
}
