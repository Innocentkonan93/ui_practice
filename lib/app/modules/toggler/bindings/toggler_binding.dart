import 'package:get/get.dart';

import '../controllers/toggler_controller.dart';

class TogglerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TogglerController>(
      () => TogglerController(),
    );
  }
}
