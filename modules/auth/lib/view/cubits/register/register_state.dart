abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}

class RegisterSuccess extends RegisterState {}
