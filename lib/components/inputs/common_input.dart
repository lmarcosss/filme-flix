import 'package:flutter/material.dart';

class CommmonInput extends StatelessWidget {
  final String text;
  final Icon? icon;
  final TextInputType? keyboardType;
  const CommmonInput(
      {super.key, required this.text, this.icon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          style: TextStyle(color: colorScheme.primary),
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            labelText: text,
            border: OutlineInputBorder(),
            prefixIcon: icon,
          ),
        ));
  }
}
