import 'package:get/get.dart';

import '../controllers/dynamic_list_controller.dart';

class DynamicListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicListController>(
      () => DynamicListController(),
    );
  }
}
