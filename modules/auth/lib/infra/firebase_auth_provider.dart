import 'package:auth/infra/models/firebase_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/data/iauthenticate_user_data.dart';
import '../domain/data/iregister_user_data.dart';

class FirebaseAuthProvider implements IAuthenticateUserData, IRegisterUserData {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthenticationResponse> authenticateWithEmailAndPassword(
      AuthenticationViewModel params) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return AuthenticationResponse(
        user: FirebaseUserModel(user: userCredential.user!).toUserEntity(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> registerWithEmailAndPassword(
      RegisterViewModel params) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return RegisterResponse(
        user: FirebaseUserModel(user: userCredential.user!).toUserEntity(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw UserAlreadyRegisteredException();
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
