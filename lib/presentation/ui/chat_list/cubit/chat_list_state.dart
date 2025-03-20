import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/data/networking/response_code.dart';
part 'chat_list_state.freezed.dart';

@freezed
abstract class ChatListState<T> with _$ChatListState<T>{
  const factory ChatListState.initial() = _Initial;
  const factory ChatListState.loading() = Loading;
  const factory ChatListState.success(T data) = Success<T>;
  const factory ChatListState.error({required ApiError error}) = Error;
}