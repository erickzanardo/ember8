import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Callback for change in user sessions
typedef UserChange = void Function(Ember8User?);

/// Add methods to the [User] class
extension UserX on User {

  /// Returns the [Ember8User] representation of this [User]
  Ember8User toGameUser() {
    return Ember8User(
      id: uid,
      name: displayName,
    );
  }
}

/// {@template auth_repository}
/// Provides authentication features to Ember8
/// {@endtemplate}
class AuthRepository {

  /// {@macro auth_repository}
  const AuthRepository({
    required FirebaseAuth auth,
  }) : _auth = auth;


  final FirebaseAuth _auth;

  /// Signs in with google
  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    }
  }

  /// Returns the current user in case any is logged in
  Ember8User? currentUser() {
    final user = _auth.currentUser;
    return user?.toGameUser();
  }

  /// Signs off the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Listens to changes on the sessions
  void listenUserState(UserChange onChange) {
    _auth.authStateChanges().listen((user) {
      onChange(
        user?.toGameUser(),
      );
    });
  }
}
