import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String _key_auth_state = 'key_auth_state';

enum AuthState {
  authenticated(true),
  unauthenticated(false);

  final bool result;

  const AuthState(this.result);

  static AuthState fromResult(bool? result) {
    return switch (result) { true => AuthState.authenticated, _ => AuthState.unauthenticated };
  }
}

class AuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  AuthState _auth = AuthState.unauthenticated;

  AuthProvider({
    required this.sharedPreferences,
  }) {
    _auth = AuthState.fromResult(sharedPreferences.getBool(_key_auth_state));
  }

  AuthState get authState => _auth;

  void login() {
    sharedPreferences.setBool(_key_auth_state, true);
    _auth = AuthState.authenticated;
    notifyListeners();
  }

  void logout() {
    sharedPreferences.setBool(_key_auth_state, false);
    _auth = AuthState.unauthenticated;
    notifyListeners();
  }
}
