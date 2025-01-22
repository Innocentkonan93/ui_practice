import 'package:flutter/material.dart';

class LighterView extends StatefulWidget {
  const LighterView({super.key});

  @override
  State<LighterView> createState() => _LighterViewState();
}

class _LighterViewState extends State<LighterView> {
  double _position = 0;
  bool showShadow = true;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position = (_position - details.delta.dy).clamp(0.0, 250.0);
      showShadow = _position > 50.0;
    });
  }

  void _onPanEnd(DragEndDetails details) {}

  List<BoxShadow> _getDynamicShadow() {
    double intensity =
        (_position / 250).clamp(0.0, 1.0); // Normaliser entre 0 et 1
    return [
      // BoxShadow(
      //   color: Colors.orange.withValues(alpha: intensity * .5),
      //   offset: Offset(
      //       30 * intensity, 0), // Étirement horizontal plus grand que vertical
      //   blurRadius: 40 * intensity,
      //   spreadRadius:
      //       10 * intensity, // Diffusion plus importante pour simuler un ovale
      // ),
      BoxShadow(
        color: Colors.orange.withValues(alpha: intensity * .5),
        offset: Offset(0 * intensity, 0 * intensity),
        blurRadius: 80 * intensity,
        spreadRadius: 10 * intensity,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: showShadow == true ? _getDynamicShadow() : null,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 250,
            width: 75,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: _position,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        boxShadow:
                            showShadow == true ? _getDynamicShadow() : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
