import 'package:chatting/core/presentation/routing/routes.dart';
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/core/presentation/widgets_common/primary_button.dart';
import 'package:chatting/presentation/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/presentation/theming/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.background,
        body: Padding(
            padding: const EdgeInsets.only(top: 100,left: 24,right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/onboarding_background.svg"),
                Text(
                    "Enjoy the new experience of\n chatting with your friends ...",
                    textAlign: TextAlign.center,
                    style: TextStyles.heading3.copyWith(fontWeight: FontWeight.w600,fontSize: 19.sp)),
                const SizedBox(height: 15),
                Text("Connect people around the world for free",
                    style: TextStyles.heading3.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp)
                        .copyWith(color: const Color(0xFFA9A6A6)),
                textAlign: TextAlign.center,),
                const Expanded(child: SizedBox()),
                PrimaryButton(
                  isEnabled: true,
                  isLoading: false,
                  text: "Get Started",
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.chatListScreen);
                  },
                ),
                const SizedBox(height: 30)
              ],
            )));
  }
}
