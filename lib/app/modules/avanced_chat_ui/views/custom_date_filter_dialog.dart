import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomDateFilterDialog extends StatelessWidget {
  const CustomDateFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: size.height * 0.85,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.7, 1.0],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final now = DateTime.now();
                        final totalDays =
                            DateTime(now.year, now.month + 1, 0).day;
                        final todayIndex = now.day - 1;
                        final controller = FixedExtentScrollController(
                          initialItem: todayIndex,
                        );

                        return ListWheelScrollView.useDelegate(
                          controller: controller,
                          itemExtent: 50,
                          diameterRatio: 2.0,
                          physics: FixedExtentScrollPhysics(),
                          perspective: 0.005,
                          overAndUnderCenterOpacity: 0.3,
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index >= totalDays) return null;
                              final day = index + 1;
                              final currentDate =
                                  DateTime(now.year, now.month, day);
                              final isToday = currentDate.day == now.day &&
                                  currentDate.month == now.month &&
                                  currentDate.year == now.year;

                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Text(
                                        '$day/${now.month}/${now.year}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: isToday
                                              ? Colors.amber[900]
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: totalDays,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
