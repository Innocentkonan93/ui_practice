import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ui_challenge/app/modules/number_led/controllers/number_led_controller.dart';

class DotGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final double dotSize;
  final Color activeColor;
  final Color inactiveColor;
  final List<List<int>>? pattern;

  const DotGrid({
    super.key,
    this.rows = 7,
    this.columns = 5,
    this.dotSize = 16,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.transparent,
    this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NumberLedController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pattern!.length, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pattern![row].length, (col) {
                  final isActive = pattern![row][col] == 1;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(4),
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: isActive ? activeColor : inactiveColor,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            }),
          );
        });
  }
}
