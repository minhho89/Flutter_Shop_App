import 'dart:ui';

import 'package:flutter/material.dart';

class NeumorphicGlass extends StatelessWidget {
  NeumorphicGlass({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.height,
    this.width,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final Widget child;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            // border: Border.all(
            //   width: 0,
            //   color: Colors.white.withOpacity(0.2),
            // ),
          ),
          child: child,
        ),
      ),
    );
  }
}
