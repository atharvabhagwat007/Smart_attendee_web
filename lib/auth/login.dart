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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  const Color.fromRGBO(66, 133, 244, 1))),
                    ),
                    //Email TextField
                    _getEmailTextField(),
                    //Password Text field
                    _getPasswordTextField(),
                    // sign in button
                    _getSignInButton(),

                    // Forgot Password button
                    _getForgotPasswordButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForgotPasswordButton() {
    return Padding(
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
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _getSignInButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(496.w, 56.h)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(66, 133, 244, 1)),
        ),
        onPressed: () async {
          // sign in with email and password
          _signInUser();
        },
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
    );
  }

  Widget _getPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: 496.w,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(66, 133, 244, 1)),
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
    );
  }

  Widget _getEmailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 496.w,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(66, 133, 244, 1)),
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
    );
  }

  void _signInUser() {
    Provider.of<AuthGaurd>(context, listen: false).loggedIn = true;
    Provider.of<AuthProvider>(context)
        .signIn(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then(
      (v) {
        if (v.success) {
          context.goNamed(RouterPaths.dashboard, params: {'tab': 'overview'});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to login'),
            ),
          );
        }
      },
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
