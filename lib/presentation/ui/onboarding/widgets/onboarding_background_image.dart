import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OnboardingBackgroundImage extends StatelessWidget {
  const OnboardingBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("assets/images/onboarding_background.svg")
      ],
    );

  }

}
