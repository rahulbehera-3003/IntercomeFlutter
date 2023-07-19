import 'package:intercom_flutter_plugin_example/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter_plugin/intercom_flutter_plugin.dart';
import 'package:provider/provider.dart';

typedef LoginWith = void Function(String credential);
typedef LoginWithEmailAndUserId = void Function(String email, String userId);

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final statusCallback = IntercomStatusCallback(
      onSuccess: () => auth.login(),
      onFailure: (_) => auth.logout(),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _AuthFormWidget(
          loginWithEmail: (email) {
            Intercom.instance.loginIdentifiedWithEmail(
              email: email,
              statusCallback: statusCallback,
            );
          },
          loginWithUserId: (userId) {
            Intercom.instance.loginIdentifiedWithUserId(
              userId: userId,
              statusCallback: statusCallback,
            );
          },
          loginIdentifiedUser: (email, userId) {
            Intercom.instance.loginIdentifiedUser(
              userId: userId,
              email: email,
              statusCallback: statusCallback,
            );
          },
          loginUnidentified: () {
            Intercom.instance.loginUnidentifiedUser(
              statusCallback: statusCallback,
            );
          },
        ),
      ),
    );
  }
}

class _AuthFormWidget extends StatefulWidget {
  const _AuthFormWidget({
    required this.loginWithEmail,
    required this.loginWithUserId,
    required this.loginIdentifiedUser,
    required this.loginUnidentified,
  });

  final LoginWith loginWithEmail;
  final LoginWith loginWithUserId;
  final LoginWithEmailAndUserId loginIdentifiedUser;
  final VoidCallback loginUnidentified;

  @override
  State<_AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<_AuthFormWidget> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _userIdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _userIdController,
            decoration: const InputDecoration(
              labelText: 'User Id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              final userId = _userIdController.text;
              final email = _emailController.text;
              if(userId.isNotEmpty && email.isNotEmpty) {
                widget.loginIdentifiedUser(email, userId);
              } else if(userId.isNotEmpty) {
                widget.loginWithUserId(userId);
              } else if(email.isNotEmpty) {
                widget.loginWithEmail(email);
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: widget.loginUnidentified,
            child: const Text('Unidentified'),
          ),
        ],
      ),
    );
  }
}
