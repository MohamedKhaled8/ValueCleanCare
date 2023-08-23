import 'package:get/get.dart';

import '../../controller/myController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyController());
    Get.lazyPut(() => MyController());
  }
}
