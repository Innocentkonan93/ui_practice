import 'package:get/get.dart';

class LoadingController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
