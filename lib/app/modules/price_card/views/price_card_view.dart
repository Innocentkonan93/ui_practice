import 'package:flutter/material.dart';

class PriceCardView extends StatefulWidget {
  const PriceCardView({super.key});

  @override
  State<PriceCardView> createState() => _PriceCardViewState();
}

class _PriceCardViewState extends State<PriceCardView> {
  bool isExpanded = false;
  bool showData = false;
  bool isSlowMotion = false;
  int animationDuration = 300;

  void handlCardBehavior() async {
    animationDuration = isSlowMotion ? 1000 : 300;
    setState(() {
      isExpanded = !isExpanded;
    });
    await Future.delayed(
        Duration(milliseconds: (animationDuration / 2).round()));
    if (isExpanded) {
      setState(() {
        showData = true;
      });
    } else {
      setState(() {
        showData = false;
      });
    }
  }

  Alignment _alignment = Alignment.topCenter; // Alignement initial

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    setState(() {
      // Calculer l'alignement en fonction du déplacement
      _alignment += Alignment(
        details.delta.dx / (size.width / 2), // Mise à l'échelle horizontale
        details.delta.dy / (size.height / 2), // Mise à l'échelle verticale
      );
      // S'assurer que l'alignement reste dans les limites [-1, 1]
      _alignment = Alignment(
        _alignment.x.clamp(-1.0, 1.0),
        _alignment.y.clamp(-1.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              AnimatedAlign(
                duration: Duration(milliseconds: animationDuration),
                alignment:
                    isExpanded == true ? Alignment.bottomCenter : _alignment,
                child: GestureDetector(
                  onTap: handlCardBehavior,
                  onPanUpdate: (details) => _onPanUpdate(details, size),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: animationDuration),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    width: isExpanded == true ? width : 100,
                    height: isExpanded == true ? height * .4 : 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: showData
                        ? ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: .6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: handlCardBehavior,
                                    child: const Icon(Icons.close_rounded),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Price"),
                                      Text(
                                        "\$7.99",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: .1),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Stocks"),
                                        SizedBox(width: 8),
                                        Text(
                                          "\$7.99",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tax"),
                                        SizedBox(width: 8),
                                        Text(
                                          "\$0.43",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Stocks",
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "\$8.42",
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isSlowMotion = !isSlowMotion;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: const Color.fromARGB(
                                        255, 99, 229, 104)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Slow Motion",
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(child: Text("\$7.99")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
