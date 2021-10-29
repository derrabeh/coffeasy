import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  CustomRaisedButton({
    required this.child,
    required this.color,
    this.borderRadius: 2,
    this.height: 50,
    required this.onPressed,
  }) : assert(borderRadius != null);

  final Widget child;
  //return type Widget means can pass text or image as child
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
