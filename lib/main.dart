import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';
import 'package:smart_attendee/auth/provider/auth_provider.dart';

import 'firebase_options.dart';
import 'routing/auth_gaurd.dart';
import 'routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final state = AuthGaurd(await AuthProvider().bootAuthenticate());
  runApp(MyApp(
    logInState: state,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.logInState});
  final AuthGaurd logInState;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthGaurd>(
          lazy: false,
          create: (BuildContext createContext) => logInState,
        ),
        ChangeNotifierProvider<GetAllEmployeeProvider>(
          create: (BuildContext createContext) => GetAllEmployeeProvider(),
        ),
        Provider<WebRouter>(
          lazy: false,
          create: (BuildContext createContext) => WebRouter(logInState),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(1440, 1024),
          builder: (context, child) {
            return Builder(builder: (context) {
              final router =
                  Provider.of<WebRouter>(context, listen: false).router;
              return MaterialApp.router(
                title: 'Smart attendee',
                debugShowCheckedModeBanner: false,
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
                routeInformationProvider: router.routeInformationProvider,
                backButtonDispatcher: router.backButtonDispatcher,
              );
            });
          }),
    );
  }
}
