import 'package:flutter/material.dart';

class CustomRowCard extends StatelessWidget {
  final String emoji;
  final String text;
  const CustomRowCard({super.key, required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}
