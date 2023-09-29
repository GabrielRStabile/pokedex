import 'package:auth/domain/data/iauthenticate_user_data.dart';
import 'package:auth/domain/entities/user_entity.dart';
import 'package:auth/main/routes/auth_module.dart';
import 'package:auth/view/cubits/login/login_cubit.dart';
import 'package:auth/view/cubits/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticateUserData extends Mock implements IAuthenticateUserData {}

void main() {
  late IAuthenticateUserData authenticateUserData;
  late LoginCubit loginCubit;

  setUpAll(() {
    Modular.bindModule(AuthModule());

    authenticateUserData = MockAuthenticateUserData();

    Modular.replaceInstance<IAuthenticateUserData>(authenticateUserData);

    loginCubit = LoginCubit();
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(loginCubit.state.runtimeType, LoginInitial);
    });

    test(
        'emits [LoginLoading, LoginSuccess] when authenticateWithEmailAndPassword succeeds',
        () async {
      final data =
          AuthenticationViewModel(email: 'test@test.com', password: 'password');

      when(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .thenAnswer(
        (_) async => AuthenticationResponse(
          user: UserEntity(
            id: 'id',
            name: 'name',
            email: 'email',
          ),
        ),
      );

      final expectedStates = [
        LoginLoading(),
        LoginSuccess(),
      ];

      expectLater(loginCubit.stream, emitsInOrder(expectedStates));

      await loginCubit.authenticate(data);

      verify(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .called(1);
    });

    test(
        'emits [LoginLoading, LoginError] when authenticateWithEmailAndPassword throws AppException',
        () async {
      final data =
          AuthenticationViewModel(email: 'test@test.com', password: 'password');
      final errorMessage = 'Invalid credentials';

      when(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .thenThrow(Exception(errorMessage));

      final expectedStates = [
        LoginLoading(),
        LoginError(errorMessage),
      ];

      expectLater(loginCubit.stream, emitsInOrder(expectedStates));

      await loginCubit.authenticate(data);

      verify(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .called(1);
    });

    test(
        'emits [LoginLoading, LoginError] when authenticateWithEmailAndPassword throws an error',
        () async {
      final data =
          AuthenticationViewModel(email: 'test@test.com', password: 'password');
      final errorMessage =
          'Ops... não conseguimos te autenticar. Tente novamente.';

      when(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .thenThrow(Exception());

      final expectedStates = [
        LoginLoading(),
        LoginError(errorMessage),
      ];

      expectLater(loginCubit.stream, emitsInOrder(expectedStates));

      await loginCubit.authenticate(data);

      verify(() => authenticateUserData.authenticateWithEmailAndPassword(data))
          .called(1);
    });
  });
}
