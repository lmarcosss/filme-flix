import 'package:filme_flix/components/buttons/primary_button.dart';
import 'package:filme_flix/components/buttons/secondary_button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/the_last_jedi.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: size.height * 0.3,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 19),
            decoration: BoxDecoration(
              color: Color(0xE6000000),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Watch movies anytime anywhere",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Text(
                    "Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )),
                PrimaryButton(
                  onPressed: () {},
                  text: "Login",
                ),
                SecondaryButton(
                  onPressed: () {},
                  text: "Sign Up",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
