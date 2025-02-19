// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
          _$NetworkErrorImpl value, $Res Function(_$NetworkErrorImpl) then) =
      __$$NetworkErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
      _$NetworkErrorImpl _value, $Res Function(_$NetworkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl();

  @override
  String toString() {
    return 'ApiError.networkError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NetworkErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return networkError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return networkError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements ApiError {
  const factory NetworkError() = _$NetworkErrorImpl;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
          _$ServerErrorImpl value, $Res Function(_$ServerErrorImpl) then) =
      __$$ServerErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
      _$ServerErrorImpl _value, $Res Function(_$ServerErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ServerErrorImpl implements ServerError {
  const _$ServerErrorImpl();

  @override
  String toString() {
    return 'ApiError.serverError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ServerErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return serverError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return serverError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements ApiError {
  const factory ServerError() = _$ServerErrorImpl;
}

/// @nodoc
abstract class _$$TooManyRequestsImplCopyWith<$Res> {
  factory _$$TooManyRequestsImplCopyWith(_$TooManyRequestsImpl value,
          $Res Function(_$TooManyRequestsImpl) then) =
      __$$TooManyRequestsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TooManyRequestsImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$TooManyRequestsImpl>
    implements _$$TooManyRequestsImplCopyWith<$Res> {
  __$$TooManyRequestsImplCopyWithImpl(
      _$TooManyRequestsImpl _value, $Res Function(_$TooManyRequestsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TooManyRequestsImpl implements TooManyRequests {
  const _$TooManyRequestsImpl();

  @override
  String toString() {
    return 'ApiError.tooManyRequests()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TooManyRequestsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return tooManyRequests();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return tooManyRequests?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (tooManyRequests != null) {
      return tooManyRequests();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return tooManyRequests(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return tooManyRequests?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (tooManyRequests != null) {
      return tooManyRequests(this);
    }
    return orElse();
  }
}

abstract class TooManyRequests implements ApiError {
  const factory TooManyRequests() = _$TooManyRequestsImpl;
}

/// @nodoc
abstract class _$$UnAuthorizedImplCopyWith<$Res> {
  factory _$$UnAuthorizedImplCopyWith(
          _$UnAuthorizedImpl value, $Res Function(_$UnAuthorizedImpl) then) =
      __$$UnAuthorizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnAuthorizedImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$UnAuthorizedImpl>
    implements _$$UnAuthorizedImplCopyWith<$Res> {
  __$$UnAuthorizedImplCopyWithImpl(
      _$UnAuthorizedImpl _value, $Res Function(_$UnAuthorizedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnAuthorizedImpl implements UnAuthorized {
  const _$UnAuthorizedImpl();

  @override
  String toString() {
    return 'ApiError.unAuthorized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnAuthorizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return unAuthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return unAuthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return unAuthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return unAuthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized(this);
    }
    return orElse();
  }
}

abstract class UnAuthorized implements ApiError {
  const factory UnAuthorized() = _$UnAuthorizedImpl;
}

/// @nodoc
abstract class _$$EmailOrPasswordNotCorrectImplCopyWith<$Res> {
  factory _$$EmailOrPasswordNotCorrectImplCopyWith(
          _$EmailOrPasswordNotCorrectImpl value,
          $Res Function(_$EmailOrPasswordNotCorrectImpl) then) =
      __$$EmailOrPasswordNotCorrectImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmailOrPasswordNotCorrectImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$EmailOrPasswordNotCorrectImpl>
    implements _$$EmailOrPasswordNotCorrectImplCopyWith<$Res> {
  __$$EmailOrPasswordNotCorrectImplCopyWithImpl(
      _$EmailOrPasswordNotCorrectImpl _value,
      $Res Function(_$EmailOrPasswordNotCorrectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmailOrPasswordNotCorrectImpl implements EmailOrPasswordNotCorrect {
  const _$EmailOrPasswordNotCorrectImpl();

  @override
  String toString() {
    return 'ApiError.emailOrPasswordNotCorrect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailOrPasswordNotCorrectImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return emailOrPasswordNotCorrect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return emailOrPasswordNotCorrect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (emailOrPasswordNotCorrect != null) {
      return emailOrPasswordNotCorrect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return emailOrPasswordNotCorrect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return emailOrPasswordNotCorrect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (emailOrPasswordNotCorrect != null) {
      return emailOrPasswordNotCorrect(this);
    }
    return orElse();
  }
}

abstract class EmailOrPasswordNotCorrect implements ApiError {
  const factory EmailOrPasswordNotCorrect() = _$EmailOrPasswordNotCorrectImpl;
}

/// @nodoc
abstract class _$$UnknownImplCopyWith<$Res> {
  factory _$$UnknownImplCopyWith(
          _$UnknownImpl value, $Res Function(_$UnknownImpl) then) =
      __$$UnknownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnknownImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$UnknownImpl>
    implements _$$UnknownImplCopyWith<$Res> {
  __$$UnknownImplCopyWithImpl(
      _$UnknownImpl _value, $Res Function(_$UnknownImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnknownImpl implements Unknown {
  const _$UnknownImpl();

  @override
  String toString() {
    return 'ApiError.unKnown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnknownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() networkError,
    required TResult Function() serverError,
    required TResult Function() tooManyRequests,
    required TResult Function() unAuthorized,
    required TResult Function() emailOrPasswordNotCorrect,
    required TResult Function() unKnown,
  }) {
    return unKnown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? networkError,
    TResult? Function()? serverError,
    TResult? Function()? tooManyRequests,
    TResult? Function()? unAuthorized,
    TResult? Function()? emailOrPasswordNotCorrect,
    TResult? Function()? unKnown,
  }) {
    return unKnown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? networkError,
    TResult Function()? serverError,
    TResult Function()? tooManyRequests,
    TResult Function()? unAuthorized,
    TResult Function()? emailOrPasswordNotCorrect,
    TResult Function()? unKnown,
    required TResult orElse(),
  }) {
    if (unKnown != null) {
      return unKnown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(TooManyRequests value) tooManyRequests,
    required TResult Function(UnAuthorized value) unAuthorized,
    required TResult Function(EmailOrPasswordNotCorrect value)
        emailOrPasswordNotCorrect,
    required TResult Function(Unknown value) unKnown,
  }) {
    return unKnown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(TooManyRequests value)? tooManyRequests,
    TResult? Function(UnAuthorized value)? unAuthorized,
    TResult? Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult? Function(Unknown value)? unKnown,
  }) {
    return unKnown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(TooManyRequests value)? tooManyRequests,
    TResult Function(UnAuthorized value)? unAuthorized,
    TResult Function(EmailOrPasswordNotCorrect value)?
        emailOrPasswordNotCorrect,
    TResult Function(Unknown value)? unKnown,
    required TResult orElse(),
  }) {
    if (unKnown != null) {
      return unKnown(this);
    }
    return orElse();
  }
}

abstract class Unknown implements ApiError {
  const factory Unknown() = _$UnknownImpl;
}
