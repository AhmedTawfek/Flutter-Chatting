import 'package:chatting/core/presentation/routing/routes.dart';
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/core/presentation/widgets_common/primary_button.dart';
import 'package:chatting/presentation/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/presentation/theming/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.background,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/onboarding_background.svg"),
                Text(
                    "Enjoy the new experience of\n chatting with your friends ...",
                    textAlign: TextAlign.center,
                    style: TextStyles.heading1),
                const SizedBox(height: 15),
                Text("Connect people around the world for free",
                    style: TextStyles.heading3
                        .copyWith(color: ColorManager.darkGrey)),
                const SizedBox(height: 30),
                PrimaryButton(
                  isEnabled: true,
                  isLoading: false,
                  text: "Get Started",
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.loginScreen);
                  },
                ),
              ],
            )));
  }
}
