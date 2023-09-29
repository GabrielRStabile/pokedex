import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class AuthenticatedRouteGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;

    if (isLoggedIn) {
      Modular.to.pushNamed('/home/');
    } else {
      Modular.to.pushNamed('/auth/login');
    }
    return true;
  }
}
