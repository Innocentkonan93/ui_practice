import 'package:get/get.dart';

import '../controllers/scratch_card_controller.dart';

class ScratchCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScratchCardController>(
      () => ScratchCardController(),
    );
  }
}
