import 'package:flutter/material.dart';

import 'dart:math';
import 'package:greenhouse_project/theme/app_theme.dart';

class Background extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
        0.1,
        0.6
      ],
          colors: [
        Color(0xffffffff),
        Color.fromARGB(255, 173, 172, 172),
      ]));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: boxDecoration,
        ),
        Positioned(top: -100, left: -25, child: _BackgroundContainer())
      ],
    );
  }
}

class _BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: RadialGradient(
                //begin: Alignment.bottomCenter,
                //end: Alignment.topCenter,
                stops: const [
                  0,
                  0.6,
                  1
                ], colors: [
              Colors.white,
              Colors.blue.shade300,
              AppTheme.primary
            ])),
      ),
    );
  }
}
