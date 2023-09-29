import 'package:auth/domain/entities/user_entity.dart';
import 'package:shared_dependencies/core/errors/app_exception.dart';

final class UserNotFoundException extends AppException {
  UserNotFoundException() : super('Ops... Não encontramos seu usuário.');
}

final class WrongPasswordException extends AppException {
  WrongPasswordException() : super('Ops... Não encontramos seu usuário.');
}

class AuthenticationViewModel {
  final String email;
  final String password;

  AuthenticationViewModel({required this.email, required this.password});

  AuthenticationViewModel copyWith({
    String? email,
    String? password,
  }) {
    return AuthenticationViewModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class AuthenticationResponse {
  final UserEntity user;

  AuthenticationResponse({
    required this.user,
  });
}

abstract interface class IAuthenticateUserData {
  Future<AuthenticationResponse> authenticateWithEmailAndPassword(
    AuthenticationViewModel params,
  );
}
