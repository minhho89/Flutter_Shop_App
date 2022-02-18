import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  NeumorphicButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.initialOffset = 5,
    this.tappedOffset = 3,
    this.initialBlurRadius = 13,
    this.tappedBlurRadius = 8,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final double initialOffset;
  final double tappedOffset;
  final double initialBlurRadius;
  final double tappedBlurRadius;

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // behavior: HitTestBehavior.translucent, // for leading of appbar
      onTap: () {
        widget.onPressed();
      },
      onTapDown: (details) => setState(() => _pressing = true),
      onTapUp: (value) => setState(() => _pressing = false),
      onTapCancel: () => setState(() => _pressing = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          // margin: const EdgeInsets.all(30),
          // neumorphic design shadow
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: widget.borderRadius,
            boxShadow: _pressing
                ? [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: Offset(widget.tappedOffset, widget.tappedOffset),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(
                          widget.tappedOffset * -1, widget.tappedOffset * -1),
                      blurRadius: 8,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset:
                          Offset(widget.initialOffset, widget.initialOffset),
                      blurRadius: 13,
                    ),
                    // bottom top left
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(
                          widget.initialOffset * -1, widget.initialOffset * -1),
                      blurRadius: 13,
                    ),
                  ],
          ),
          child: Stack(
            children: [
              Center(child: widget.child),
              Container(
                width: widget.width,
                height: widget.height,
                decoration: _pressing
                    ? BoxDecoration(
                        borderRadius: widget.borderRadius,
                        color: Colors.grey.shade600.withOpacity(0.1),
                      )
                    : BoxDecoration(
                        color: Colors.transparent,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
