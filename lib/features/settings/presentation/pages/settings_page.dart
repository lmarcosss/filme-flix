import 'package:filme_flix/core/widgets/header/header_widget.dart';
import 'package:filme_flix/core/widgets/working_progress/working_progress_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String route = "/settings";

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Settings"),
      body: WorkingProgress(),
    );
  }
}
