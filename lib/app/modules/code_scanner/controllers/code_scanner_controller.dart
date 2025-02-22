import 'dart:async';
import 'package:get/get.dart';

class CodeScannerController extends GetxController {
  var isScanning = false.obs;
  var scanPosition = 0.0.obs; // Position du scanner

  @override
  void onInit() {
    super.onInit();
    _startScanningAnimation();
  }

  void _startScanningAnimation() {
    Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      scanPosition.value =
          scanPosition.value == 0 ? 350 : 0; // Monte et descend
    });
  }
}
