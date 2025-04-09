import 'package:chatting/core/domain/utils/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

class FirebaseStorageErrorCode implements CoreError {
  static const String unknown = 'unknown';
  static const String objectNotFound = 'object-not-found';
  static const String bucketNotFound = 'bucket-not-found';
  static const String projectNotFound = 'project-not-found';
  static const String quotaExceeded = 'quota-exceeded';
  static const String unauthenticated = 'unauthenticated';
  static const String unauthorized = 'unauthorized';
  static const String retryLimitExceeded = 'retry-limit-exceeded';
  static const String invalidChecksum = 'invalid-checksum';
  static const String canceled = 'canceled';
  static const String invalidEventName = 'invalid-event-name';
  static const String invalidUrl = 'invalid-url';
  static const String invalidArgument = 'invalid-argument';
  static const String noDefaultBucket = 'no-default-bucket';
  static const String cannotSliceBlob = 'cannot-slice-blob';
  static const String serverFileWrongSize = 'server-file-wrong-size';
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
    }else if(exception is FirebaseException) {
      return _HandleStorageException().handleError(exception);
    }else{
      return const ApiError.unKnown();
    }
  }
}

class _HandleFirebaseAuthException{
  ApiError handleError(FirebaseAuthException firebaseAuthException){
    switch(firebaseAuthException.code){
      case FirebaseAuthErrorCode.invalidEmail || FirebaseAuthErrorCode.wrongPassword || FirebaseAuthErrorCode.invalidCredential:
        return const ApiError.emailOrPasswordNotCorrect();
      default:
        return const ApiError.unKnown();
    }
  }
}

class _HandleStorageException{
  ApiError handleError(FirebaseException exception){
    switch(exception.code){
      case FirebaseStorageErrorCode.unauthenticated || FirebaseStorageErrorCode.unauthorized:
        return const ApiError.unAuthorized();
      default:
        return const ApiError.unKnown();
    }
  }
}