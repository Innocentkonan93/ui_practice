import 'package:get/get.dart';

import '../controllers/tall_selection_controller.dart';

class TallSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TallSelectionController>(
      () => TallSelectionController(),
    );
  }
}
