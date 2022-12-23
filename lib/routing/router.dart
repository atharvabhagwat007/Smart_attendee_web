import 'package:go_router/go_router.dart';
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
              state.namedLocation(RouterPaths.dashboard, params: {
                'tab': 'overview',
              }),
              ),
          GoRoute(
              name: RouterPaths.dashboard,
              path:
                  '${RouterPaths.dashboardPath}/:tab(overview|add_client|add_employee|add_shift|reports)',
              builder: (context, state) => Dashboard(
                tab: state.params['tab']!,
              ),
            )
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
    },
  );
}
