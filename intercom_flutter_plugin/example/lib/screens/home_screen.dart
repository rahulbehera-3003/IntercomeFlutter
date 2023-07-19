import 'dart:async';

import 'package:intercom_flutter_plugin_example/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter_plugin/intercom_flutter_plugin.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isShowLauncher = false;
  bool _isShowInAppMessages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intercom example app'),
        actions: [
          IconButton(
            onPressed: () {
              Intercom.instance.logout();
              context.read<AuthProvider>().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Show/Hide launcher'),
            value: _isShowLauncher,
            onChanged: (value) {
              final visibility = switch (value) {
                true => IntercomVisibility.visible,
                _ => IntercomVisibility.gone,
              };
              Intercom.instance.setLauncherVisibility(visibility);
              setState(() => _isShowLauncher = value);
            },
          ),
          SwitchListTile(
            title: const Text('Show/Hide In App Messages'),
            value: _isShowInAppMessages,
            onChanged: (value) {
              final visibility = switch (value) {
                true => IntercomVisibility.visible,
                _ => IntercomVisibility.gone,
              };
              Intercom.instance.setInAppMessagesVisibility(visibility);
              setState(() => _isShowInAppMessages = value);
            },
          ),
          ListTile(
            title: const Text('Display messenger'),
            onTap: () => Intercom.instance.displayMessenger(),
          ),
          ListTile(
            title: const Text('Hide messenger after 5 seconds'),
            onTap: () async {
              await Intercom.instance.displayMessages();
              await Future.delayed(
                const Duration(seconds: 5),
                    () => Intercom.instance.hideMessenger(),
              );
            },
          ),
          ListTile(
            title: const Text('Display message composer'),
            onTap: () async {
              final message = await showDialog(
                context: context,
                builder: (_) => const _DialogWidget(),
              );
              if(message != null) {
                Intercom.instance.displayMessageComposer(message);
              }
            },
          ),
          ListTile(
            title: const Text('Display help center'),
            onTap: () => Intercom.instance.displayHelpCenter(),
          ),
          ListTile(
            title: const Text('Display messages'),
            onTap: () => Intercom.instance.displayMessages(),
          ),
          ListTile(
            title: const Text('Count unread conversation'),
            trailing: StreamBuilder<int>(
              stream: Intercom.instance.getUnreadStream(),
              builder: (context, snapshot) => Text('${snapshot.data ?? 0}'),
            ),
          )
        ],
      ),
    );
  }
}

class _DialogWidget extends StatefulWidget {
  const _DialogWidget();

  @override
  State<_DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<_DialogWidget> {

  TextEditingController? _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Display messenger with compose'),
      content: TextFormField(
        controller: _messageController,
        decoration: const InputDecoration(
          labelText: 'Your message',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () {
            final message = _messageController?.text ?? '';
            if(message.isNotEmpty) {
              Navigator.pop(context, message);
            }
          },
          child: const Text('Open'),
        ),
      ],
    );
  }
}
