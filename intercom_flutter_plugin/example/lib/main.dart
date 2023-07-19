import 'package:intercom_flutter_plugin_example/src/app.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter_plugin/intercom_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: make sure to add keys from your Intercom workspace.
  await Intercom.instance.initialize(
    appId: appId,
    androidApiKey: androidApiKey,
    iosApiKey: iosApiKey,
  );
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(App(sharedPreferences: sharedPreferences));
}
