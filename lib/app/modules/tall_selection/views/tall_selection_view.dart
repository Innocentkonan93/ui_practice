import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TallSelectionView extends StatelessWidget {
  TallSelectionView({super.key});

  final RxDouble selectedHeight = 160.0.obs; // Valeur initiale en cm
  static int milimeters = 10;
  static int barCount = 30;
  final ruleHeight = milimeters * barCount + 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height Selection'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Obx(() {
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Centimeters"),
                    Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                    const Text("Inches"),
                  ],
                ),

                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // Met à jour la taille selon le déplacement du doigt
                    double newHeight =
                        selectedHeight.value - details.delta.dy / 5;
                    if (newHeight >= 0) {
                      selectedHeight.value = newHeight;
                    }
                  },
                  child: Container(
                    height: ruleHeight.toDouble(),
                    margin: EdgeInsets.only(left: 10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(),
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        // Positioned(
                        //   top: (barCount * milimeters) - selectedHeight.value,
                        //   left: 0,
                        //   right: 0,
                        //   child:
                        // ),
                        Row(
                          children: [
                            // Règle interactive
                            GestureDetector(
                              onVerticalDragUpdate: (details) {
                                // Met à jour la taille selon le déplacement du doigt
                                double newHeight =
                                    selectedHeight.value - details.delta.dy / 5;
                              },
                              child: Container(
                                // color: AppColors.lightPurple,
                                width: 30,
                                height: barCount * 10,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 101,
                                  itemBuilder: (context, index) {
                                    bool isCentimeter = index % milimeters == 0;
                                    return SizedBox(
                                      height: 5,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: isCentimeter ? 30 : 15,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Contenu (image/avatar...)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      height: selectedHeight.value,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            color: Colors.amber,
                                          ),
                                          // Icon(
                                          //   Icons.person_2_rounded,
                                          //   size: selectedHeight.value,
                                          // ),
                                        ],
                                      )
                                      // FlutterLogo(
                                      //   size: selectedHeight.value,
                                      // ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   top: (barCount * milimeters) - selectedHeight.value,
                        //   left: 0,
                        //   right: 0,
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           height: 2,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //           color: AppColors.red,
                        //           borderRadius: BorderRadius.circular(
                        //             20,
                        //           ),
                        //         ),
                        //         child: Text(
                        //           selectedHeight.toStringAsFixed(0) + " cm",
                        //           style: theme.textTheme.titleLarge?.copyWith(
                        //             color: AppColors.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // Switch pour cm/inches
                Text(
                  "Selected Height: ${selectedHeight.value.toInt()} cm",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        ),
      ),
    );
  }
}
