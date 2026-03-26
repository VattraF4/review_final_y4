// Form validation example with name, email, password, and confirm password fields.
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: RegisterPage());
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name     = TextEditingController();
  final _email    = TextEditingController();
  final _password = TextEditingController();
  final _confirm  = TextEditingController();
  bool _obscure   = true;

  @override
  void dispose() {
    _name.dispose(); _email.dispose();
    _password.dispose(); _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            // Name
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Full Name'),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            // Email
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v ?? '')
                      ? null
                      : 'Enter a valid email',
            ),
            const SizedBox(height: 12),
            // Password
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password (min 8)',
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (v) =>
                  (v != null && v.length >= 8) ? null : 'Min 8 characters',
            ),
            const SizedBox(height: 12),
            // Confirm Password
            TextFormField(
              controller: _confirm,
              obscureText: _obscure,
              decoration:
                  const InputDecoration(labelText: 'Confirm Password'),
              validator: (v) =>
                  (v == _password.text) ? null : 'Passwords do not match',
            ),
            const SizedBox(height: 20),
            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Register'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}