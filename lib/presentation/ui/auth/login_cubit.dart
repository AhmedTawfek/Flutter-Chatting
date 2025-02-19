import 'package:chatting/core/data/networking/response_code.dart';
import 'package:chatting/core/presentation/validations_utils/validation_utils.dart';
import 'package:chatting/data/auth/remote/sign_in_data_source.dart';
import 'package:chatting/presentation/ui/auth/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  Future<void> signIn() async {

    FormData currentFormData = getFormData();

    print('delaying is finished');

    final signInResult = await SignInDataSource().signIn(email: currentFormData.email, password: currentFormData.password);

    signInResult.when(
        success: (data) => {
          print('signed in sucessfully')
        },
        failure: (error) => {
          emit(LoginState.error(error: error as ApiError, currentFormData: currentFormData))
        });

    print('signed in... = $signInResult');

  }

  FormData getFormData(){

    return state.when(
        initial: () => const FormData(email: '', password: '', isValid: false),
        loading: (formData) => formData,
        success: (data) => const FormData(email: '', password: '', isValid: false),
        error: (error,formData) => formData,
        formData: (email,password,emailError,passwordError,isValid) => FormData(email: email, password: password,emailError: emailError,passwordError: passwordError, isValid: isValid));

  }

  void updateEmail({required String email}) {
    FormData currentFormData = getFormData();

    if (email == currentFormData.email) return;

    print("Updating email | currentFormData =$currentFormData");
    emit(LoginState.formData(
      email: email,
      password: currentFormData.password ?? '',
      emailError: currentFormData.emailError,
      passwordError: currentFormData.passwordError,
      isValid: currentFormData.isValid ?? false
    ));
  }

  void updatePassword({required String password}) {
    FormData currentFormData = getFormData();

    if (password == currentFormData.password) return;

    print("Updating password | currentFormData =$currentFormData");

    emit(LoginState.formData(
      email: currentFormData.email ?? '',
      password: password,
      emailError: currentFormData.emailError,
      passwordError: currentFormData.passwordError,
      isValid: currentFormData.isValid ?? false
    ));
  }

  void validateEmail() {
    if (state is FormData && (state as FormData).email.isEmpty) {
      _updateValidationErrors(emailError: null);
      return;
    }

    bool isEmailIsCorrect = ValidationUtils().isEmailCorrect((state as FormData).email);

    print('statement isEmailIsCorrect =$isEmailIsCorrect');
    if (isEmailIsCorrect) {
      _updateValidationErrors(emailError: '');
    } else {
      _updateValidationErrors(emailError: 'Email is not correct');
    }
  }

  void validatePassword() {
    if (state is FormData && (state as FormData).password.isEmpty) {
      _updateValidationErrors(passwordError: null);
      return;
    }
    bool isPasswordCorrect = ValidationUtils().isPasswordCorrect(password: (state as FormData).password);

    print('statement is password correct =$isPasswordCorrect');

    if (isPasswordCorrect) {
      _updateValidationErrors(passwordError: '');
    } else {
      _updateValidationErrors(passwordError: 'Password is not correct');
    }
  }

  void _updateValidationErrors({String? emailError, String? passwordError}) {
    final currentState = state as FormData;

    final isFormValid = (emailError == null || emailError.isEmpty) && (passwordError == null || passwordError.isEmpty) && currentState.email.isNotEmpty && currentState.password.isNotEmpty;
    final currentEmailError = (emailError != null && emailError.isEmpty) ? null : (emailError ?? currentState.emailError);
    final currentPasswordError = (passwordError != null && passwordError.isEmpty) ? null : (passwordError ?? currentState.passwordError);

    emit(LoginState.formData(email: currentState.email, password: currentState.password,emailError: currentEmailError,passwordError: currentPasswordError,isValid: isFormValid));
  }
}