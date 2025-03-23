import 'package:chatting/core/presentation/di/dependency_inections.dart';
import 'package:chatting/core/presentation/routing/routes.dart';
import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:chatting/presentation/ui/auth/login_screen.dart';
import 'package:chatting/presentation/ui/chat/chat_screen.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_cubit.dart';
import 'package:chatting/presentation/ui/chat_list/chat_list_screen.dart';
import 'package:chatting/presentation/ui/chat_list/cubit/chat_list_cubit.dart';
import 'package:chatting/presentation/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chat/model/chat_list_model.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getItInstance<LoginCubit>(),
                child: const LoginScreen()));
      case Routes.chatListScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
            create: (context) => getItInstance<ChatListCubit>(),
            child: const ChatListScreen()));
      case Routes.chatScreen:
        final chatListModel = arguments as ChatListModel; // Cast the arguments to ChatListModel
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getItInstance<ChatCubit>(),
                child: ChatScreen(
                  selectedChatListModel: chatListModel,
                )));
      default:
        return null;
    }
  }
}