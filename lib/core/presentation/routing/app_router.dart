import 'package:chatting/core/presentation/di/dependency_inections.dart';
import 'package:chatting/core/presentation/routing/routes.dart';
import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:chatting/presentation/ui/auth/login_screen.dart';
import 'package:chatting/presentation/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

      print("generateRoute func settings=${settings.name} | ${settings.arguments}");
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        print("Entered case for loginScreens");
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getItInstance<LoginCubit>(),
                child: const LoginScreen()));
      default:
        return null;
    }
  }
}
