import 'package:get/get.dart';

import '../controllers/data_extractor_controller.dart';

class DataExtractorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataExtractorController>(
      () => DataExtractorController(),
    );
  }
}
