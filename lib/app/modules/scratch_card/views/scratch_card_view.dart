import 'dart:typed_data';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ScratchCardView extends StatefulWidget {
  const ScratchCardView({super.key});

  @override
  ScratchCardViewState createState() => ScratchCardViewState();
}

class ScratchCardViewState extends State<ScratchCardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scratch Card'),
      ),
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 691 / 1056,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          padding: const EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return FlipCard(
              key: ValueKey(index),
              fill: Fill.fillFront,
              flipOnTouch: true,
              front: Image.asset("assets/images/5D.png"),
              back: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: .6)
                    // boxShadow:
                    ),
                child: const Center(child: Text('Back')),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScratchCardPainter extends CustomPainter {
  final List<Offset?> points;
  final ui.Image? image;
  final bool reveal;

  ScratchCardPainter({required this.points, this.image, required this.reveal});

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      // Dessiner l'image de fond
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: image!,
        fit: BoxFit.cover,
      );

      if (!reveal) {
        // Créer un chemin pour les points gommés
        Path path = Path();
        for (int i = 0; i < points.length; i++) {
          if (points[i] != null) {
            if (i == 0) {
              path.moveTo(points[i]!.dx, points[i]!.dy);
            } else {
              path.lineTo(points[i]!.dx, points[i]!.dy);
            }
          }
        }

        // Dessiner le fond rouge initial
        Paint backgroundPaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

        canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
        canvas.drawRect(
            Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

        // Utiliser clipPath pour créer l'effet de gommage
        canvas.clipPath(path);

        // Effacer la peinture rouge dans les zones gommées
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
            Paint()..blendMode = BlendMode.clear);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(ScratchCardPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.image != image ||
        oldDelegate.reveal != reveal;
  }
}
