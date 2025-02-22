import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/code_scanner_controller.dart';

class CodeScannerView extends GetView<CodeScannerController> {
  const CodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fond du scanner
                Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),

                // Animation de balayage
                Obx(() {
                  return AnimatedPositioned(
                    top: controller.scanPosition.value,
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeInOut,
                    child: Container(
                      height: 8,
                      width: 350,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withValues(alpha: .8),
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
