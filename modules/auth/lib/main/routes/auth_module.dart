import 'package:auth/infra/firebase_auth_provider.dart';
import 'package:auth/view/pages/login_page.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/data/iauthenticate_user_data.dart';
import '../../domain/data/iregister_user_data.dart';
import '../../view/cubits/login/login_cubit.dart';
import '../../view/cubits/register/register_cubit.dart';
import '../../view/pages/register_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    //Providers
    i.add<IAuthenticateUserData>(FirebaseAuthProvider.new);
    i.add<IRegisterUserData>(FirebaseAuthProvider.new);

    //Cubits
    i.add<LoginCubit>(
      LoginCubit.new,
      config: BindConfig(onDispose: (cubit) => cubit.close()),
    );
    i.add<RegisterCubit>(
      RegisterCubit.new,
      config: BindConfig(onDispose: (cubit) => cubit.close()),
    );
  }

  @override
  void routes(r) {
    r.child('/login', child: (_) => LoginPage());
    r.child('/register', child: (_) => RegisterPage());
  }
}
