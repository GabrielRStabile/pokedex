import 'package:shared_dependencies/core/errors/app_exception.dart';

import '../entities/user_entity.dart';

final class UserAlreadyRegisteredException extends AppException {
  UserAlreadyRegisteredException()
      : super('Parece que você já tem uma conta aqui. Tenta logar!');
}

class RegisterViewModel {
  final String email;
  final String password;

  RegisterViewModel({required this.email, required this.password});

  RegisterViewModel copyWith({
    String? email,
    String? password,
  }) {
    return RegisterViewModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class RegisterResponse {
  final UserEntity user;

  RegisterResponse({
    required this.user,
  });
}

abstract interface class IRegisterUserData {
  Future<RegisterResponse> registerWithEmailAndPassword(
    RegisterViewModel params,
  );
}
