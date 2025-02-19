import 'package:chatting/core/domain/utils/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'response_code.freezed.dart';


class FirebaseAuthErrorCode implements CoreError {
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';
  static const String accountExistsWithDifferentCredential = 'account-exists-with-different-credential';
  static const String invalidCredential = 'invalid-credential';
  static const String tooManyRequests = 'too-many-requests';
  static const String networkRequestFailed = 'network-request-failed';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String invalidVerificationId = 'invalid-verification-id';
}

@freezed
abstract class ApiError with _$ApiError implements CoreError {
  const factory ApiError.networkError() = NetworkError;
  const factory ApiError.serverError() = ServerError;
  const factory ApiError.tooManyRequests() = TooManyRequests;
  const factory ApiError.unAuthorized() = UnAuthorized;
  const factory ApiError.emailOrPasswordNotCorrect() = EmailOrPasswordNotCorrect;
  const factory ApiError.unKnown() = Unknown;
}

class ErrorHandler{
  ApiError handleError(Exception exception){
    if (exception is FirebaseAuthException){
      print('entered FirebaseAuthException');
      return _HandleFirebaseAuthException().handleError(exception);
    }else{
      return const ApiError.unKnown();
    }
  }
}

class _HandleFirebaseAuthException{
  ApiError handleError(FirebaseAuthException firebaseAuthException){
    print('firebaseAuthException =>${firebaseAuthException.code}');
    switch(firebaseAuthException.code){
      case FirebaseAuthErrorCode.invalidEmail || FirebaseAuthErrorCode.wrongPassword || FirebaseAuthErrorCode.invalidCredential:
        return const ApiError.emailOrPasswordNotCorrect();
      default:
        return const ApiError.unKnown();
    }
  }
}