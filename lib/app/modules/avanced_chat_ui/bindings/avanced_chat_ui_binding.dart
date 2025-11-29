import 'package:get/get.dart';

import '../controllers/avanced_chat_ui_controller.dart';

class AvancedChatUiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvancedChatUiController>(
      () => AvancedChatUiController(),
    );
  }
}
