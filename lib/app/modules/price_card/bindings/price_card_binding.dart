import 'package:get/get.dart';

import '../controllers/price_card_controller.dart';

class PriceCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PriceCardController>(
      () => PriceCardController(),
    );
  }
}
