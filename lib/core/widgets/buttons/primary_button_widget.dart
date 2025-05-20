import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.padding,
    this.height,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: SizedBox(
          width: screenSize.width,
          height: height ?? 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              backgroundColor: backgroundColor ?? colorScheme.primary,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
