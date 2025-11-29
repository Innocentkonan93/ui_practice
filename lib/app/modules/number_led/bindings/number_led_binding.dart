import 'package:get/get.dart';

import '../controllers/number_led_controller.dart';

class NumberLedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumberLedController>(
      () => NumberLedController(),
    );
  }
}
