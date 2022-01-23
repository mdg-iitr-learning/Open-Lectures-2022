import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 70.0, fontFamily: 'Canterbury', color: Colors.blue),
        child: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText(" Let's "),
            ScaleAnimatedText('Learn'),
            ScaleAnimatedText('Flutter!'),
          ],
          onTap: () {},
        ),
      ),
    );
  }
}
