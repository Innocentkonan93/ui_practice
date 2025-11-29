import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/number_led/views/dot_grid.dart';
import 'package:ui_challenge/app/utils/constantes.dart';

import '../controllers/number_led_controller.dart';

class NumberLedView extends GetView<NumberLedController> {
  const NumberLedView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(NumberLedController());
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NumberLedView'),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: NumberLedController(),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotGrid(
                  pattern: numberPatterns[controller.currentNumber.value]!,
                  dotSize: 40,
                ),
                const SizedBox(height: 40),
                Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(10, (index) {
                    final number = index;
                    final isSelected = controller.currentNumber.value == number;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? Colors.blue : Colors.grey[200],
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        shape: CircleBorder(),
                        elevation: isSelected ? 8 : 2,
                        minimumSize: Size(56, 56),
                        side: isSelected
                            ? const BorderSide(
                                color: Colors.blueAccent, width: 2)
                            : BorderSide.none,
                      ),
                      onPressed: isSelected
                          ? null
                          : () {
                              controller.setCurrentNumber(number);
                            },
                      child: Text(
                        number.toString(),
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 22,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
    );
  }
}
