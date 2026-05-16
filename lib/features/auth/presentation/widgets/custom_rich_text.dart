import 'package:city_tales/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account?",
        style: TextStyle(color: Colors.black54),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ),
            text: " Sign Up",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
