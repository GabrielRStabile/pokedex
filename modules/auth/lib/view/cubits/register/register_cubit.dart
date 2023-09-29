import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/data/iregister_user_data.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _registerUserData = Modular.get<IRegisterUserData>();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(RegisterViewModel data) async {
    try {
      emit(RegisterLoading());

      await _registerUserData.registerWithEmailAndPassword(data);

      emit(RegisterSuccess());
    } on AppException catch (e) {
      emit(RegisterError(e.message));
    } catch (e) {
      emit(
        RegisterError('Ops... não conseguimos te registrar. Tente novamente.'),
      );
    }
  }
}
