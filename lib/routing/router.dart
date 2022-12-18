import 'package:go_router/go_router.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/desktop_nav/dashboard.dart';

import '../auth/login.dart';
import 'auth_gaurd.dart';
import 'routes.dart';

// Class containing implementation of go router for web navigation

class WebRouter {
  final AuthGaurd loginGaurd;

  WebRouter(this.loginGaurd);

  late final router = GoRouter(
      refreshListenable: loginGaurd,
      initialLocation: RouterPaths.homePath,
      debugLogDiagnostics: true,
      routes: <GoRoute>[
        GoRoute(
          name: RouterPaths.login,
          path: RouterPaths.loginPath,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
            name: RouterPaths.home,
            path: RouterPaths.homePath,
            redirect: (context, state) =>
                state.namedLocation(RouterPaths.dashboard),
            routes: [
              GoRoute(
                name: RouterPaths.dashboard,
                path: RouterPaths.dashboardPath,
                builder: (context, state) => const Dashboard(),
              )
            ]),
      ],
      redirect: (context, state) {
        final loginLoc = state.namedLocation(RouterPaths.login);
        final loggingIn = state.subloc == loginLoc;
        final loggedIn = loginGaurd.loggedInState;
        final rootLoc = state.namedLocation(RouterPaths.home);

        if (!loggedIn && !loggingIn) return loginLoc;
        if (loggedIn && (loggingIn)) {
          return rootLoc;
        }
        return null;
      });
}
