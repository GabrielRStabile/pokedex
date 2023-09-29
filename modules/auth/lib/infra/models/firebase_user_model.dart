import 'package:auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserModel {
  final String uid;
  final String photoURL;
  final String email;
  final String displayName;

  FirebaseUserModel({required User user})
      : uid = user.uid,
        photoURL = user.photoURL ?? '',
        email = user.email ?? '',
        displayName = user.displayName ?? '';

  UserEntity toUserEntity() => UserEntity(
        id: uid,
        name: displayName,
        email: email,
      );
}
