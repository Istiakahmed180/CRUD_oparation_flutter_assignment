import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarName;
  final bool isBackEnabled;

  const CustomAppBar({
    super.key,
    required this.appBarName,
    required this.isBackEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBackEnabled
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )
          : null,
      title: Text(
        appBarName,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.lightBlue,
    );
  }
}
