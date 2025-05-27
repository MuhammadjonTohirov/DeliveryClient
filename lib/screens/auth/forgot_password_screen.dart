import 'package:flutter/material.dart';
import 'package:delivery_client/utils/constants.dart';
// import 'package:delivery_client/screens/auth/login_screen.dart'; // For navigation

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _linkSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      // Simulate sending link
      setState(() {
        _linkSent = true;
      });
      print('Reset link sent to: ${_emailController.text}');
      // TODO: Implement actual password reset logic (e.g., Firebase Auth)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password reset link sent to ${_emailController.text}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!_linkSent) ...[
                Text(
                  'Enter your email address and we will send you a link to reset your password.',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding * 2),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: kDefaultPadding * 1.5),
                ElevatedButton(onPressed: _sendResetLink, child: const Text('Send Reset Link')),
              ] else ...[
                // Success message state
                const Icon(Icons.check_circle_outline, color: kSuccessColor, size: 80),
                const SizedBox(height: kDefaultPadding),
                Text(
                  'Password Reset Link Sent!',
                  style: theme.textTheme.headlineSmall?.copyWith(color: kSuccessColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  'A password reset link has been sent to your email address: ${_emailController.text}. Please check your inbox (and spam folder).',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding * 2),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    // Or navigate specifically to login:
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                  child: const Text('Back to Login'),
                ),
              ],
              const SizedBox(height: kDefaultPadding),
              if (!_linkSent)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to the previous screen (likely Login)
                  },
                  child: const Text('Back to Sign In'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
