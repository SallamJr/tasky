import 'package:flutter/material.dart';

class CustomClickableDetector extends StatelessWidget {
  const CustomClickableDetector({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
  });

  final Widget child;
  final Function()? onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
      onTap: onPressed,
      child: child,
    );
  }
}
