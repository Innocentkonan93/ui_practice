import 'package:get/get.dart';

import '../controllers/code_scanner_controller.dart';

class CodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeScannerController>(
      () => CodeScannerController(),
    );
  }
}
