import 'package:auth/main/routes/auth_module.dart';
import 'package:favorite/main/routes/favorite_module.dart';
import 'package:home/main/routes/home_module.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/auth', module: AuthModule());
    r.module(
      '/home',
      module: HomeModule(),
    );
    r.module(
      '/favorite',
      module: FavoriteModule(),
    );
  }
}
