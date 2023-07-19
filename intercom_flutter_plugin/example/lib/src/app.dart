import 'package:intercom_flutter_plugin_example/providers/auth_provider.dart';
import 'package:intercom_flutter_plugin_example/screens/auth_screen.dart';
import 'package:intercom_flutter_plugin_example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(sharedPreferences: sharedPreferences),
      child: MaterialApp(
        home: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return switch(provider.authState) {
              AuthState.authenticated => const HomeScreen(),
              _ => const AuthScreen(),
            };
          },
        ),
      ),
    );
  }
}
