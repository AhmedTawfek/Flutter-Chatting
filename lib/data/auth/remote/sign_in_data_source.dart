import 'package:chatting/core/data/networking/api_result.dart';
import 'package:chatting/core/data/networking/response_code.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInDataSource{

    Future<ApiResult<String>> signIn({required String email,required String password}) async {

      try{
          final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          return ApiResult.success(authResult.credential?.token.toString()??'');
      } on Exception catch (exc){
        print('Catched exception =type${exc.runtimeType}');
        return ApiResult.failure(ErrorHandler().handleError(exc));
      }

    }
}