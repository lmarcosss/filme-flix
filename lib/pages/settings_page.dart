import 'package:filme_flix/components/header/header.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(title: "Settings"),
        body: ListView(
          children: [],
        ));
  }
}
