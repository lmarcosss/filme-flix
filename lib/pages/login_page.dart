import 'package:filme_flix/components/buttons/primary_button.dart';
import 'package:filme_flix/components/inputs/common_input.dart';
import 'package:filme_flix/components/inputs/password_input.dart';
import 'package:filme_flix/routes/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    void onLogin() {
      context.go(RoutesConstants.home);
    }

    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              "Login",
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
        PasswordInput(text: "Password"),
        PrimaryButton(
            onPressed: onLogin,
            text: "Login",
            padding: EdgeInsets.only(left: 16, right: 16, top: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Haven't made an account? "),
            InkWell(
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  context.replace(RoutesConstants.signUp);
                })
          ],
        )
      ],
    ));
  }
}
