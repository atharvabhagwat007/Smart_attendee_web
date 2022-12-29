import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/auth/provider/auth_provider.dart';
import 'package:smart_attendee/routing/auth_gaurd.dart';

import '../routing/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String ERROR_TEXT = 'Something went wrong!';

  String _errorText = '';

  bool _isErrorText = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> legacyAuth() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authState = await context.read<AuthProvider>().legacyAuth(
          email: _emailController.text,
          password: _passwordController.text,
          persistAuth: false);
      if (authState.success) {
        if (!mounted) return;
        Provider.of<AuthGaurd>(context, listen: false).loggedIn = true;
        context.goNamed(RouterPaths.dashboard, params: {'tab': 'overview'});
      } else {
        snackbarMessage(authState.message ?? ERROR_TEXT);
      }
    } else {
      snackbarMessage('Please enter mail and password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      builder: (context, child) => Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              width: 1158.w,
              height: 588.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Error Text 1
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          _isErrorText ? _errorText : 'Login to get started',
                          textAlign: TextAlign.left,
                          style: _isErrorText
                              ? customTextStyle(Colors.red)
                              : customTextStyle(
                                  const Color.fromRGBO(66, 133, 244, 1),
                                ),
                        ),
                      ),
                      //Email TextField
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: 496.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(66, 133, 244, 1)),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            controller: _emailController,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Color.fromRGBO(66, 133, 244, 1),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(66, 133, 244, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Password Text field
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: 496.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(66, 133, 244, 1)),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            obscureText: true,
                            controller: _passwordController,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromRGBO(66, 133, 244, 1),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(66, 133, 244, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // sign in button
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(496.w, 56.h)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(66, 133, 244, 1)),
                          ),
                          onPressed: legacyAuth,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 20.sp,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                        ),
                      ),

                      // Forgot Password button
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot password?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 16.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void snackbarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 20,
          child: Text(message),
        ),
      ),
    );
  }

  TextStyle customTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 30,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    );
  }
}
