import 'dart:io';

import 'package:get/get.dart';

class SampleScreenController extends GetxController {
  List<File> samplesImages = [];

  updateUi() {
    samplesImages.isNotEmpty ? update() : null;
  }
}
