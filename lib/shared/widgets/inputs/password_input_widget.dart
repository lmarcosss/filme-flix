import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String text;
  const PasswordInput({
    super.key,
    required this.text,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscuredPassword = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          style: TextStyle(color: colorScheme.primary),
          obscureText: isObscuredPassword,
          decoration: InputDecoration(
            labelText: widget.text,
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock, color: colorScheme.primary),
            suffixIcon: IconButton(
              icon: Icon(
                isObscuredPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  isObscuredPassword = !isObscuredPassword;
                });
              },
            ),
          ),
        ));
  }
}
