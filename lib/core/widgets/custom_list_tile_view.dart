import 'package:flutter/material.dart';

class CustomListTileView extends StatelessWidget {
  const CustomListTileView({
    super.key,
    required this.title,
    this.color,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  final String title;
  final Color? color;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: color,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: trailing,
    );
  }
}
