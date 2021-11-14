import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:zen_app/core/models/user.dart';
import 'package:zen_app/domain/auth/failures/auth_failure.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth? _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

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
  Future<void> register(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [logInWithGoogle] if an exception occurs.
  Future<void> logInWithGoogle() async {
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
      print(credentials);
    } catch (_) {
      throw LogInWithGoogleFailure();
    }
  }

  Future<firebase_auth.UserCredential?> logInWithApple() async {
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
  Future<firebase_auth.UserCredential?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print('Trying to log with credentials $email');
    try {
      final credentials = await _firebaseAuth?.signInWithEmailAndPassword(
        email: email,
        password: password,
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
  Future<void> logOut() async {
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
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName!,
      photo: photoURL!,
      emailVerified: emailVerified,
    );
  }
}
