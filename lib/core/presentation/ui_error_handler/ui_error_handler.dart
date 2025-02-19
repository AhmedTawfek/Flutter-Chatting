
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/networking/response_code.dart';

class UiErrorHandler{

  static String getErrorMessage(BuildContext context,ApiError error){
    return error.when(
      networkError: () => AppLocalizations.of(context)!.internetError,
      serverError: () => AppLocalizations.of(context)!.unknownError, // Add proper text
      tooManyRequests: () => AppLocalizations.of(context)!.unknownError, // Add proper text
      unAuthorized: () => AppLocalizations.of(context)!.unknownError, // Add proper text
      emailOrPasswordNotCorrect: () => AppLocalizations.of(context)!.emailOrPasswordError,
      unKnown: () => AppLocalizations.of(context)!.unknownError,
    );
  }

}