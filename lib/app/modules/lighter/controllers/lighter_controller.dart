import 'package:get/get.dart';

class LighterController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
