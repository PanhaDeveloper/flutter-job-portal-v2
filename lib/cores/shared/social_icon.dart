import 'package:flutter/material.dart';

class SocialMediaIcon extends StatelessWidget {
  final String iconPath;
  const SocialMediaIcon({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 204, 204, 204),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(child: Image.asset(iconPath, width: 40)),
    );
  }
}
