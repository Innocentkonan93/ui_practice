import 'package:get/get.dart';

import '../controllers/page_transition_controller.dart';

class PageTransitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageTransitionController>(
      () => PageTransitionController(),
    );
  }
}
