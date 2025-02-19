import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:chatting/core/presentation/ui_error_handler/ui_error_handler.dart';
import 'package:chatting/core/presentation/utils/button_states.dart';
import 'package:chatting/core/presentation/widgets_common/primary_button.dart';
import 'package:chatting/core/presentation/widgets_common/primary_snackbar.dart';
import 'package:chatting/core/presentation/widgets_common/primary_text_field.dart';
import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:chatting/presentation/ui/auth/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/theming/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Text('Welcome Back :)', style: TextStyles.heading1),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in, so you can use all of our app features.',
                      style: TextStyles.heading4
                          .copyWith(color: ColorManager.darkGrey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocSelector<LoginCubit, LoginState, String?>(
                      selector: (state) {
                        return state is FormData ? state.emailError : null;
                      },
                      builder: (context, emailError) {

                        return PrimaryTextField(
                          hintText: 'Email',
                          errorText: emailError,
                          onTextChange: (value){
                            context.read<LoginCubit>().updateEmail(email: value);
                            if (emailError != null && emailError.isNotEmpty){
                              context.read<LoginCubit>().validateEmail();
                            }
                          },
                          onFocusChange: (hasFocus){
                            if (!hasFocus){
                              context.read<LoginCubit>().validateEmail();
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    BlocSelector<LoginCubit, LoginState, String?>(
                      selector: (state){
                        return state is FormData ? state.passwordError : null;
                      },
                      builder: (context, passwordError) {
                        return PrimaryTextField(
                          hintText: 'Password',
                          errorText: passwordError,
                          onTextChange: (value){
                            context.read<LoginCubit>().updatePassword(password: value);
                            if (passwordError!= null && passwordError.isNotEmpty){
                              context.read<LoginCubit>().validatePassword();
                            }
                          },
                          onFocusChange: (hasFocus){
                            if (!hasFocus){
                              context.read<LoginCubit>().validatePassword();
                            }
                          },
                        );
                      },
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: BlocSelector<LoginCubit, LoginState, Enum>(
                              selector: (state) {
                                if (state is Loading){
                                  return ButtonState.loading;
                                } else if (state is FormData && state.emailError == null && state.passwordError == null && state.email.isNotEmpty && state.password.isNotEmpty){
                                  return ButtonState.enabled;
                                }else if(state is Error){
                                  return ButtonState.enabled;
                                }else{
                                  return ButtonState.disabled;
                                }
                              },
                              builder: (context, buttonState) {
                                return PrimaryButton(
                                    isEnabled: (buttonState == ButtonState.enabled) ? true : false,
                                    isLoading: (buttonState == ButtonState.loading) ? true : false,
                                    text: 'Sign In',
                                    onPressed: () {
                                      context.read<LoginCubit>().signIn();
                                    });
                              },
                            ))),
                    const SizedBox(height: 20),
                    BlocListener<LoginCubit, LoginState>(
                      listenWhen: (previous, current) => current is Error,
                      listener: (context, state) {
                        if (state is Error) {
                          final errorMessage = UiErrorHandler.getErrorMessage(context, state.error);
                          PrimarySnackbar.show(context, message: errorMessage);
                        }
                      },
                      child: const SizedBox.shrink(), // Or your main widget tree if you have other content
                    )
                  ],
                ))));
  }
}
