import 'package:flutter/material.dart';

class NavButtons extends StatelessWidget {
  const NavButtons({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  });

  final Icon icon;
  final double iconSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: icon,
      iconSize: iconSize,
      onPressed: onPressed,
    );
  }
}
