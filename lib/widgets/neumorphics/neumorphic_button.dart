import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => setState(() => _pressing = true),
      onTapUp: (value) => setState(() => _pressing = false),
      onTapCancel: () => setState(() => _pressing = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.all(30),
          // neumorphic design shadow
          decoration: BoxDecoration(
            color: _pressing ? Colors.grey[350] : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            boxShadow: _pressing
                ? [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(3, 3),
                      blurRadius: 8,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-3, -3),
                      blurRadius: 8,
                    ),
                  ]
                : [
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
          child: widget.child,
        ),
      ),
    );
  }
}