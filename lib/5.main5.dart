// Local State
// Local State ត្រូវបាន manageនៅក្នុង StatfulWidgets​តែមួយដោយប្រើ setState()។
//​

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterPage());
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local State Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter', style: const TextStyle(fontSize: 48)),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => setState(() => _counter++),
              icon: const Icon(Icons.add),
              label: const Text('Increase'),
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () => setState(() => _liked = !_liked),
              icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              iconSize: 32,
            ),
            Text(_liked? 'Liked!' : 'Not Liked', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
