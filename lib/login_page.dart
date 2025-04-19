import 'package:filme_flix/components/buttons/primary_button.dart';
import 'package:filme_flix/components/inputs/common_input.dart';
import 'package:filme_flix/components/inputs/password_input.dart';
import 'package:filme_flix/components/nav_bar/logged_nav_bar.dart';
import 'package:filme_flix/sign_up_page.dart';
import 'package:flutter/material.dart';

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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoggedNavBar()),
        (Route<dynamic> route) => false,
      );
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                })
          ],
        )
      ],
    ));
  }
}
