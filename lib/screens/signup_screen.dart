// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import '../blocs/auth/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final user = await _authService.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null && mounted) {
          context.read<AuthBloc>().add(LoggedIn(user));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sign up for Silentverce', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (val) => val == null || !val.contains('@') ? 'Enter valid email' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (val) => val == null || val.length < 6 ? 'Password too short' : null,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signup,
                        child: const Text('Sign Up'),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Already have an account? Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
