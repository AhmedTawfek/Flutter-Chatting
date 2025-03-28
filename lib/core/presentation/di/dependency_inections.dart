import 'package:chatting/core/data/local/local_preferences_data_source.dart';
import 'package:chatting/core/data/local/sqlite_data_base.dart';
import 'package:chatting/data/chat/remote/ChatFireStoreDataSource.dart';
import 'package:chatting/data/chat/repo/ChatRepo.dart';
import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_cubit.dart';
import 'package:chatting/presentation/ui/chat/cubit/chat_state.dart';
import 'package:chatting/presentation/ui/chat_list/cubit/chat_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../../../data/chat/local/chat_local_data_source.dart';

final getItInstance = GetIt.instance;

Future<void> setupGetIt() async {

  final sharedPreferenceInstance = await SharedPreferences.getInstance();

  getItInstance.registerFactory<LoginCubit>(() => LoginCubit());
  getItInstance.registerFactory<ChatCubit>(() => ChatCubit(ChatState(),getItInstance()));

  getItInstance.registerLazySingleton<ChatRepo>(()=>ChatRepo(firestoreDataSource: getItInstance(), localDataSource: getItInstance()));

  getItInstance.registerFactory<ChatLocalDataSource>(() => ChatLocalDataSource(sqliteInstance: getItInstance()));

  getItInstance.registerFactory<LocalPreferencesDataBase>(() => LocalPreferencesDataBase(instance: sharedPreferenceInstance));

  getItInstance.registerSingleton<SqliteDatabase>(SqliteDatabase.instance);

  getItInstance.registerSingletonAsync<BriteDatabase>(() async => SqliteDatabase.instance.database);

  getItInstance.registerFactory<ChatFirestoreDataSource>(()=> ChatFirestoreDataSource());

  getItInstance.registerFactory<ChatListCubit>(() => ChatListCubit(getItInstance()));

  await getItInstance.allReady();
}