import 'package:get/get.dart';

class NumberLedController extends GetxController {
  final currentNumber = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentNumber(int number) {
    currentNumber.value = number;
    update();
  }
}
