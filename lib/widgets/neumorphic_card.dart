import 'package:flutter/material.dart';

class NeumorphicCard extends StatelessWidget {
  const NeumorphicCard(
      {Key? key, required this.child, required this.shadowBlur})
      : super(key: key);

  final Widget child;
  final double shadowBlur;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      // neumorphic design shadow
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        // top bottom right
        BoxShadow(
          color: Colors.grey.shade600,
          offset: const Offset(5, 5),
          blurRadius: shadowBlur,
        ),
        // bottom top left
        BoxShadow(
          color: Colors.white,
          offset: const Offset(-5, -5),
          blurRadius: shadowBlur,
        ),
      ]),
      child: child,
    );
  }
}
