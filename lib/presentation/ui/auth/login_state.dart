import 'package:chatting/core/data/networking/response_code.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';



@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading({required FormData currentFormData}) = Loading;
  const factory LoginState.success(T data) = Success<T>;
  const factory LoginState.error({required ApiError error,required FormData currentFormData}) = Error;
  const factory LoginState.formData({required String email,required String password,String? emailError,String? passwordError,required bool isValid}) = FormData;
}