import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;

  const SearchInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
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
            prefixIcon: Icon(Icons.search, color: colorScheme.primary),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: colorScheme.primary),
                    onPressed: () {
                      controller.clear();
                    },
                  )
                : null,
          ),
        ));
  }
}
