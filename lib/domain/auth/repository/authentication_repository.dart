import 'package:firebase_auth/firebase_auth.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/params/login_with_email_and_password.dart';
import 'package:zen_app/data/auth/params/register_user_params.dart';

abstract class AuthenticationRepository {
  Future<void> register(RegisterUserRequestParams params);
  Future<void> logInWithGoogle(NoParams noParams);
  Future<void> logInWithApple(NoParams noParams);
  Future<UserCredential?> logInWithEmailAndPassword(
      LoginWithEmailAndPasswordRequestParams params);
  Future<void> logOut(NoParams noParams);
}
