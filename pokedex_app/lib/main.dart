import 'package:favorite/infra/hive_favorite_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/theme/color_schemes.g.dart';
import 'package:pokedex_app/theme/decorations.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import 'firebase_options.dart';
import 'main/routes/app_module.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait([
    Hive.initFlutter(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    )
  ]);

  // if (kDebugMode) {
  //   await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  // }

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    HiveFavoriteRepository.registerAdapter();

    ValidationBuilder.setLocale('pt-br');

    FlutterNativeSplash.remove();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;

    Modular.setInitialRoute(isLoggedIn ? '/home/' : '/auth/login');

    return ModularApp(
      module: AppModule(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          inputDecorationTheme: inputDecoration,
          elevatedButtonTheme: elevatedButtonTheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          inputDecorationTheme: inputDecoration,
          elevatedButtonTheme: elevatedButtonTheme,
        ),
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
