import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/data/iauthenticate_user_data.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authenticateUserData = Modular.get<IAuthenticateUserData>();

  LoginCubit() : super(LoginInitial());

  Future<void> authenticate(AuthenticationViewModel data) async {
    try {
      emit(LoginLoading());

      await _authenticateUserData.authenticateWithEmailAndPassword(data);

      emit(LoginSuccess());
    } on AppException catch (e) {
      emit(LoginError(e.message));
    } catch (e) {
      emit(
        LoginError('Ops... não conseguimos te autenticar. Tente novamente.'),
      );
    }
  }
}
