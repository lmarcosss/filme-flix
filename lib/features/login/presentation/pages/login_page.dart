import 'package:filme_flix/features/home/presentation/pages/home_page.dart';
import 'package:filme_flix/features/sign-up/presentation/pages/sign_up_page.dart';
import 'package:filme_flix/shared/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:filme_flix/shared/presentation/widgets/inputs/common_input_widget.dart';
import 'package:filme_flix/shared/presentation/widgets/inputs/password_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    void onLogin() {
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
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                child:
                    Text("Sign Up", style: TextStyle(color: Colors.blueAccent)),
                onTap: () {
                  context.replace(SignUpPage.route);
                })
          ],
        )
      ],
    ));
  }
}
