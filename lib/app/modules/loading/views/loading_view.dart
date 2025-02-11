import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:lottie/lottie.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  bool canShow = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          canShow = true;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Center(
              child: Lottie.asset(
                'assets/animations/1739174737399.json',
                repeat: false,
                height: 400,
                onLoaded: (p0) {
                  // print(p0.duration);
                },
              ),
            ),
            if (canShow)
              Center(
                child: Image.asset(
                  'assets/images/konan.png',
                  height: 200,
                ),
              ).animate().scaleXY(),
          ],
        ),
      ),
    );
  }
}
