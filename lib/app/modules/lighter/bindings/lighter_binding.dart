import 'package:get/get.dart';

import '../controllers/lighter_controller.dart';

class LighterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LighterController>(
      () => LighterController(),
    );
  }
}
