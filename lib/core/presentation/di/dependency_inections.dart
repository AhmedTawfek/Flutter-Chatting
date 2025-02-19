import 'package:chatting/presentation/ui/auth/login_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

Future<void> setupGetIt() async {
  getItInstance.registerFactory<LoginCubit>(() => LoginCubit());
}