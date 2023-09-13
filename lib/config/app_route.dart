import 'package:discuss_app/page/home_page.dart';
import 'package:go_router/go_router.dart';

import '../model/user.dart';
import '../page/erorr_page.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';
import 'session.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

  static GoRouter routerConfig = GoRouter(
    errorBuilder: (context, state) => ErorrPage(
      title: 'Something Erorr',
      description: state.error.toString(),
    ),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      User? user = await Session.getUser();
      if (user == null) {
        if (state.location == login || state.location == register) {
          return null;
        }

        return login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => RegisterPage(),
      ),
    ],
  );
}
