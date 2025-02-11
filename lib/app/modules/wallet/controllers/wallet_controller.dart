import 'package:get/get.dart';

class WalletController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
