import 'package:chatting/data/chat/remote/ChatFireStoreDataSource.dart';
import 'package:chatting/data/chat/repo/ChatRepo.dart';
import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_cubit.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_state.dart';
import 'package:chatting/presentation/ui/chat_list/cubit/chat_list_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

Future<void> setupGetIt() async {
  getItInstance.registerFactory<LoginCubit>(() => LoginCubit());
  getItInstance.registerFactory<ChatCubit>(() => ChatCubit(ChatState()));
  getItInstance.registerFactory<ChatListCubit>(
      () => ChatListCubit(ChatRepo(ChatFirestoreDataSource())));
}