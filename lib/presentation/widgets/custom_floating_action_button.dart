import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onPressed;
  const CustomFloatingActionButton(
      {super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Colors.lightBlue,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
