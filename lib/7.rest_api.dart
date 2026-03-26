//Login with REST API (POST Request)

// Login ដោយប្រើ REST API
// [EN] Use http.post() with JSON headers and body to authenticate.
//Parse the response with jsonDecode(). Navigate on success, show error on failure.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}

class AuthService {
  Future<String> login(String email, String password) async {

    final url = Uri.parse('http://localhost/api_testing/api/login.php');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      return data['token'] ?? '';
    } else {
      final err = jsonDecode(resp.body);
      throw Exception(err['error'] ?? 'Login failed');
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final token = await _auth.login(_email.text.trim(), _pass.text.trim());
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage(token: token)),
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    (v != null && v.contains('@')) ? null : 'Invalid email',
              ),
              TextFormField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) =>
                    (v != null && v.length >= 6) ? null : 'Min 6 chars',
              ),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String token;
  const HomePage({super.key, required this.token});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(child: Text('Token: $token')),
  );
}
