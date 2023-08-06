import 'package:flutter/material.dart';

class DevelopedByView extends StatelessWidget {
  const DevelopedByView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        text: 'Developed by ',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: 'Crafted Internet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
