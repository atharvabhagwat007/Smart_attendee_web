import 'package:flutter/material.dart';


class AuthGaurd extends ChangeNotifier {
  bool _loggedinState;

  AuthGaurd([bool? loginState])
      : _loggedinState = loginState ??
            false;

  bool get loggedInState => _loggedinState;
  set loggedIn(bool value) {
    _loggedinState = value;
    notifyListeners();
  }
}
