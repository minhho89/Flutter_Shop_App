import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  final Text buttonText;
  final VoidCallback onPressed;

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      // neumorphic design shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: _pressing
            ? [
                BoxShadow(
                  color: Colors.grey.shade600,
                  offset: const Offset(-5, -5),
                  blurRadius: 13,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 5),
                  blurRadius: 13,
                ),
              ]
            : [
                // top bottom right
                BoxShadow(
                  color: Colors.grey.shade600,
                  offset: const Offset(5, 5),
                  blurRadius: 13,
                ),
                // bottom top left
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, -5),
                  blurRadius: 13,
                ),
              ],
      ),
      child: GestureDetector(
        child: widget.buttonText,
        onTap: widget.onPressed,
        onTapDown: (details) => setState(() => _pressing = true),
        onTapUp: (value) => setState(() => _pressing = false),
        onTapCancel: () => setState(() => _pressing = false),
      ),
    );
  }
}
