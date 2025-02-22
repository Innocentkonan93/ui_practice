import 'package:get/get.dart';

import '../controllers/kki_list_controller.dart';

class KkiListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KkiListController>(
      () => KkiListController(),
    );
  }
}
