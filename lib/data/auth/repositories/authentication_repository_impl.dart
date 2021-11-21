import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/params/login_with_email_and_password.dart';
import 'package:zen_app/data/auth/params/register_user_params.dart';
import 'package:zen_app/data/user/models/user_model.dart';
import 'package:zen_app/domain/auth/failures/auth_failure.dart';
import 'package:zen_app/data/user/repositories/user_repository.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';
import 'package:zen_app/domain/entities/user.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth? _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn? _googleSignIn = GoogleSignIn.standard();

  String generateNonce([int length = 32]) {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Stream<User> get user {
    return _firebaseAuth!.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  @override
  Future<void> register(RegisterUserRequestParams params) async {
    try {
      final userData = await _firebaseAuth!.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      var user = UserModel(
        id: userData.user!.uid,
        email: params.email,
        emailVerified: userData.user!.emailVerified,
      );

      await UserRepository().updateOrRegister(user: user);
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [logInWithGoogle] if an exception occurs.
  @override
  Future<void> logInWithGoogle(NoParams noParams) async {
    try {
      print('Trying to log with google');
      final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final credentials = await _firebaseAuth!.signInWithCredential(credential);
      final user = UserModel(
        id: credentials.user!.uid,
        email: credentials.user!.email,
        niceName: credentials.user!.displayName ?? '',
        emailVerified: credentials.user!.emailVerified,
        photo: credentials.user!.photoURL ?? '',
      );

      await UserRepository().updateOrRegister(user: user);
      print(credentials);
    } catch (_) {
      print(_);
      throw LogInWithGoogleFailure();
    }
  }

  @override
  Future<firebase_auth.UserCredential?> logInWithApple(
      NoParams noParams) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential =
          firebase_auth.OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      return await _firebaseAuth?.signInWithCredential(oauthCredential);
    } catch (e) {
      throw LogInWithAppleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<firebase_auth.UserCredential?> logInWithEmailAndPassword(
      LoginWithEmailAndPasswordRequestParams params) async {
    print('Trying to log with credentials ${params.email}');
    try {
      final credentials = await _firebaseAuth?.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return credentials;
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut(NoParams noParams) async {
    try {
      await Future.wait([
        _firebaseAuth!.signOut(),
        _googleSignIn!.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth?.currentUser;
    return currentUser != null;
  }

  firebase_auth.User? getUser() {
    return _firebaseAuth?.currentUser;
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName!,
      photo: photoURL!,
      emailVerified: emailVerified,
    );
  }
}
