import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final double? height;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: SizedBox(
          width: size.width,
          height: height ?? 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: colorScheme.primary,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
