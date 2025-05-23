import 'package:filme_flix/core/widgets/buttons/primary_button_widget.dart';
import 'package:filme_flix/core/widgets/inputs/common_input_widget.dart';
import 'package:filme_flix/core/widgets/inputs/password_input_widget.dart';
import 'package:filme_flix/features/home/presentation/pages/home_page.dart';
import 'package:filme_flix/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  static const String route = "/sign-up";

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    void onSignUp() {
      context.go(HomePage.route);
    }

    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
        CommmonInput(
          text: "Email",
          keyboardType: TextInputType.emailAddress,
          icon: Icon(Icons.email, color: colorScheme.primary),
        ),
        SizedBox(height: 8),
        CommmonInput(
          text: "Username",
          icon: Icon(Icons.person, color: colorScheme.primary),
        ),
        SizedBox(height: 8),
        PasswordInput(text: "Password"),
        PrimaryButton(
            onPressed: onSignUp,
            text: "Create Account",
            padding: EdgeInsets.only(left: 16, right: 16, top: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            InkWell(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  context.replace(LoginPage.route);
                })
          ],
        )
      ],
    ));
  }
}
