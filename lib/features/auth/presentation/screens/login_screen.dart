import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                FadeInDown(
                  child: Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeInDown(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Sign in to continue your health journey',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 48),
                FadeInLeft(
                  delay: const Duration(milliseconds: 200),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                FadeInLeft(
                  delay: const Duration(milliseconds: 300),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                FadeInRight(
                  delay: const Duration(milliseconds: 400),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign In'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle Google Sign In
                      },
                      icon: const Icon(Icons.g_mobiledata, size: 32),
                      label: const Text('Continue with Google'),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        context.go('/');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
