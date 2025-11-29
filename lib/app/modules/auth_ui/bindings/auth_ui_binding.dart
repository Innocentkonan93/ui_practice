import 'package:get/get.dart';

import '../controllers/auth_ui_controller.dart';

class AuthUiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthUiController>(
      () => AuthUiController(),
    );
  }
}
