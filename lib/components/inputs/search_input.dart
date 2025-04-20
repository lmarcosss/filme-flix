import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          style: TextStyle(color: colorScheme.primary),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Search for a title...",
            hintStyle: TextStyle(color: colorScheme.primary, fontSize: 16),
            filled: true,
            fillColor: Color(0xFF2B2930),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(
              color: colorScheme.primary,
            ),
            prefixIcon: Icon(Icons.menu, color: colorScheme.primary),
            suffixIcon: Icon(Icons.search, color: colorScheme.primary),
          ),
        ));
  }
}
